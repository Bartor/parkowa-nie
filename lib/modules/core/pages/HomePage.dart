import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/settings/pages/SettingsPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _listItem({Widget child}) => Card(
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            print('Tapped');
          },
          child:
              Container(height: 100, padding: EdgeInsets.all(15), child: child),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new report',
              textAlign: TextAlign.center,
            ),
            Icon(Icons.add)
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Hero(
            child: Text('parkowaNIE',
                style: Theme.of(context).textTheme.headline5),
            tag: 'bar/title',
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage()));
                })
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              _newReportButton(),
              Divider(),
              Expanded(
                child: Consumer<DatabaseService>(
                  builder: (context, DatabaseService, widget) {
                    if (DatabaseService == null ||
                        DatabaseService.reports == null) {
                      return CircularProgressIndicator();
                    } else {
                      if (DatabaseService.reports.isEmpty) {
                        return Text('No historic data');
                      } else {
                        return ListView(
                          physics: BouncingScrollPhysics(),
                          children: DatabaseService.reports
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
        ));
  }
}
