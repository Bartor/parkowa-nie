import 'dart:io';

import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/common/format-date.dart';
import 'package:parkowa_nie/modules/core/common/show-image-preview.dart';
import 'package:parkowa_nie/modules/core/model/ContactInformation.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/CitiesService.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:parkowa_nie/modules/core/widgets/ImageButton.dart';
import 'package:parkowa_nie/modules/core/data/build-message-body.dart';
import 'package:parkowa_nie/modules/core/widgets/YesNoDialog.dart';
import 'package:parkowa_nie/modules/report/pages/CreateReportPage.dart';
import 'package:parkowa_nie/modules/settings/pages/SettingsPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ReportDetails extends StatefulWidget {
  final Report report;
  final int reportId;
  ReportDetails({this.report, this.reportId});

  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  int _reportId;
  Report _report;
  List<Widget> _photos;

  @override
  void initState() {
    super.initState();

    _report = widget.report;
    _photos = _buildPhotos(widget.report);
    _reportId = widget.reportId;
  }

  List<Widget> _buildPhotos(Report report) {
    return report.photoUris
        .asMap()
        .entries
        .map((entry) => ImageButton(
              onTap: () {
                _previewPhoto(entry.key);
              },
              photoFile: File(entry.value),
            ))
        .toList();
  }

  Future<void> _sendEmail() async {
    ContactInformation contactInfo =
        Provider.of<DatabaseService>(context, listen: false).contact;

    if (contactInfo == null ||
        (contactInfo.address ?? "").isEmpty ||
        (contactInfo.fullName ?? "").isEmpty) {
      final updateInfo = await showDialog(
          context: context,
          builder: (_) => YesNoDialog(
                title: Text("Missing info".i18n),
                content: Text(
                    "You haven't set your contact information. Do you want to set it now?"
                        .i18n),
              ));
      if (updateInfo ?? false) {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SettingsPage()));
        contactInfo =
            Provider.of<DatabaseService>(context, listen: false).contact;
      }
    }

    final recipient = await Provider.of<CitiesService>(context, listen: false)
        .resolveEmail(_report.city);
    if (recipient == null) {
      final doContinue = await showDialog(
          context: context,
          builder: (_) => YesNoDialog(
                title: Text("Unknown city".i18n),
                content: Text(
                    "We don't have this city's email address in the database. Do you want to put it in manually?"
                        .i18n),
              ));
      if (!(doContinue ?? false)) return;
    }

    final MailOptions email = MailOptions(
      body: buildMessageBody(report: _report, contactInfo: contactInfo),
      subject: 'Zgłoszenie nieprawidłowego parkowania',
      recipients: [recipient],
      attachments: _report.photoUris,
      isHTML: false,
    );

    try {
      final result = await FlutterMailer.send(email);
      switch (result) {
        case MailerResponse.saved:
        case MailerResponse.sent:
        case MailerResponse.android:
          _report.sent = true;
          await Provider.of<DatabaseService>(context, listen: false)
              .updateReport(report: _report, id: _reportId);
          break;
        default:
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("There was an error".i18n)));
    }
  }

  Future<void> _deleteReport() async {
    await Provider.of<DatabaseService>(context, listen: false)
        .deleteReport(reportId: _reportId);
    Navigator.of(context).pop();
    final dirs = [
      await getApplicationSupportDirectory(),
      ...await getExternalStorageDirectories()
    ];

    _report.photoUris.forEach((path) {
      if (dirs.any((dir) => path.contains(dir.path))) {
        File(path).delete();
      }
    });
  }

  Future<void> _previewPhoto(int index) async {
    Navigator.of(context)
        .push(showImagePreview(widget.report.photoUris, index));
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      actions: [
        IconButton(icon: Icon(Icons.delete_rounded), onPressed: _deleteReport)
      ],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Parking report".i18n,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              formatDate(_report.dateTime),
              textAlign: TextAlign.center,
            ),
            Divider(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Address'.i18n,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ": "),
                    TextSpan(text: "${_report.address}, ${_report.city}")
                  ])),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Licence plate'.i18n,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ": "),
                    TextSpan(
                        text: _report.licensePlate ?? "No licence plate".i18n)
                  ])),
                  Divider(),
                  _report.offenses.isEmpty
                      ? Text("No offences".i18n)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _report.offenses
                              .map((e) => Text(e.i18n))
                              .toList()),
                  Divider(),
                  _photos.isEmpty
                      ? Text("No photos".i18n)
                      : GridView.count(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children: _photos,
                        )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: _sendEmail, child: Text('Send'.i18n))),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.of(context)
                              .push<Report>(MaterialPageRoute(
                                  builder: (_) => CreateReportPage(
                                        report: _report,
                                        reportId: _reportId,
                                      )));
                          if (result != null) {
                            setState(() {
                              _report = result;
                              _photos = _buildPhotos(result);
                            });
                          }
                        },
                        child: Text('Edit'.i18n)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
