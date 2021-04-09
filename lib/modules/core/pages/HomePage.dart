import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/common/format-date.dart';
import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:parkowa_nie/modules/report/pages/CreateReportPage.dart';
import 'package:parkowa_nie/modules/report/pages/ReportDetailsPage.dart';
import 'package:parkowa_nie/modules/settings/pages/SettingsPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _listItem({Widget child, Function onTap}) => Card(
        child: InkWell(
          splashColor: Colors.white60,
          onTap: onTap,
          child: Container(padding: EdgeInsets.all(15), child: child),
        ),
      );

  Widget _buildReportCard(Report report, int id) => _listItem(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ReportDetails(
                  reportId: id,
                  report: report,
                )));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: report.city,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: " - "),
                      TextSpan(
                          text: report.address,
                          style: TextStyle(fontWeight: FontWeight.normal))
                    ]),
              ),
              Text(formatDate(report.dateTime)),
              Text(report.licensePlate ?? "No licence plate".i18n)
            ],
          ),
          report.sent ?? false ? Icon(Icons.check) : Icon(Icons.save)
        ],
      ));

  Widget _newReportButton() => _listItem(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CreateReportPage()));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              child: Text(
                'Add new report'.i18n,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              tag: 'text/addNewReport',
            ),
            Icon(Icons.add)
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Layout(
      actions: [
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SettingsPage()));
            })
      ],
      body: Column(
        children: [
          _newReportButton(),
          Divider(),
          Expanded(
            child: Consumer<DatabaseService>(
              builder: (context, databaseService, widget) {
                if (databaseService == null ||
                    databaseService.reports == null) {
                  return CircularProgressIndicator();
                } else {
                  if (databaseService.reports.isEmpty) {
                    return Text('No historic data'.i18n);
                  } else {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: databaseService.reports.entries
                          .map((e) => _buildReportCard(e.value, e.key))
                          .toList(),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
