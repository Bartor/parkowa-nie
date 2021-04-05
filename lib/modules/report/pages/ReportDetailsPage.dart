import 'dart:io';

import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/common/format-date.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:parkowa_nie/modules/core/widgets/ImageButton.dart';
import 'package:parkowa_nie/modules/core/data/build-message-body.dart';
import 'package:parkowa_nie/modules/core/data/city-email-addresses.dart';
import 'package:parkowa_nie/modules/report/pages/CreateReportPage.dart';
import 'package:provider/provider.dart';

class ReportDetails extends StatefulWidget {
  Report report;
  final int reportId;
  ReportDetails({this.report, this.reportId});

  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  Report _report;
  int _reportId;

  @override
  void initState() {
    super.initState();

    _report = widget.report;
    _reportId = widget.reportId;
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      actions: [
        IconButton(
            icon: Icon(Icons.delete_rounded),
            onPressed: () async {
              await Provider.of<DatabaseService>(context, listen: false)
                  .deleteReport(reportId: _reportId);
              Navigator.of(context).pop();
            })
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          _report.offences.map((e) => Text(e.i18n)).toList()),
                  Divider(),
                  GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: _report.photoUris
                        .map((uri) => ImageButton(
                              photoFile: File(uri),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () async {
                          final contactInfo = Provider.of<DatabaseService>(
                                  context,
                                  listen: false)
                              .contact;

                          final receipent = getCityEmail(city: _report.city);
                          if (receipent == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('This city has no email defined')));
                            return;
                          }

                          final MailOptions email = MailOptions(
                            body: buildMessageBody(
                                report: _report, contactInfo: contactInfo),
                            subject: 'Zgłoszenie nieprawidłowego parkowania',
                            recipients: [receipent],
                            attachments: _report.photoUris,
                            isHTML: false,
                          );

                          try {
                            await FlutterMailer.send(email);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("There was an error".i18n)));
                          }
                        },
                        child: Text('Send'.i18n))),
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
