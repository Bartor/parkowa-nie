import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:parkowa_nie/modules/core/common/format-date.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:provider/provider.dart';

class ReportDetails extends StatelessWidget {
  final Report report;
  final int reportId;
  ReportDetails({this.report, this.reportId});

  @override
  Widget build(BuildContext context) {
    return Layout(
      actions: [
        IconButton(
            icon: Icon(Icons.delete_rounded),
            onPressed: () async {
              await Provider.of<DatabaseService>(context, listen: false)
                  .deleteReport(reportId: reportId);
              Navigator.of(context).pop();
            })
      ],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("Parking report".i18n),
                  Text(report.city),
                  Text(report.address),
                  Text(report.licensePlate ?? "No licence plate".i18n),
                  Text(formatDate(report.dateTime)),
                  Wrap(
                    children: report.offences.map((e) => Text(e.i18n)).toList(),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final Email email = Email(
                    body: "Test body",
                    subject: 'Email subject',
                    recipients: ['example@example.com'],
                    attachmentPaths: [],
                    isHTML: false,
                  );

                  try {
                    await FlutterEmailSender.send(email);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("There was an error".i18n)));
                  }
                },
                child: Text('Send'.i18n))
          ],
        ),
      ),
    );
  }
}
