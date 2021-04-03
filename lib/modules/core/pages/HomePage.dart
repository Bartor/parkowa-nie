import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:parkowa_nie/modules/report/pages/CreateReportPage.dart';
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

  Widget _buildReportCard({Report report}) => _listItem(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${report.address}, ${report.city}"),
          Text(DateFormat('y/MM/dd H:m').format(report.dateTime)),
          Wrap(
            children: report.offences.map((e) => Text(e)).toList(),
          )
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
                'Add new report',
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
      settings: true,
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
                    return Text('No historic data');
                  } else {
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: databaseService.reports
                          .map((e) => _buildReportCard(report: e))
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
