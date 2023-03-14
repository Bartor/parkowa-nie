import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/common/format-date.dart';
import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:parkowa_nie/modules/report/pages/CreateReportPage.dart';
import 'package:parkowa_nie/modules/report/pages/ReportDetailsPage.dart';
import 'package:parkowa_nie/modules/settings/pages/SettingsPage.dart';
import 'package:parkowa_nie/modules/statistics/pages/StatisticsPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onlyNotSent = false;

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

  Iterable<MapEntry<dynamic, Report>> _filterReports(
      Map<dynamic, Report> reportMap) {
    final filteredReports = onlyNotSent
        ? reportMap.entries.where((element) => !element.value.sent)
        : reportMap.entries;
    filteredReports
        .toList()
        .sort((a, b) => a.value.dateTime.compareTo(b.value.dateTime));

    return filteredReports;
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      actions: [
        IconButton(
          icon: Icon(Icons.bar_chart),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => StatisticsPage()));
          },
        ),
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
          SwitchListTile(
              activeColor: Colors.indigo,
              title: Text('Show only not yet sent?'.i18n),
              value: onlyNotSent,
              onChanged: (bool value) {
                setState(() {
                  onlyNotSent = value;
                });
              }),
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
                    final reportWidgets =
                        _filterReports(databaseService.reports)
                            .map((e) => _buildReportCard(e.value, e.key))
                            .toList();

                    if (reportWidgets.isEmpty) {
                      return Text('All reports already sent!'.i18n);
                    } else {
                      return ListView(
                        physics: BouncingScrollPhysics(),
                        children: reportWidgets,
                      );
                    }
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
