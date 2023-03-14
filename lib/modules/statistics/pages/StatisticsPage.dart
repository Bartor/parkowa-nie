import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<Report> reports = [];

  @override
  initState() {
    super.initState();

    reports = Provider.of<DatabaseService>(context, listen: false)
        .reports
        .values
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Reports total'.i18n,
          ),
          Text(
            reports.length.toString(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Divider(),
          Text('Reports sent'.i18n),
          Text(
            reports.where((element) => element.sent).length.toString(),
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
    ));
  }
}
