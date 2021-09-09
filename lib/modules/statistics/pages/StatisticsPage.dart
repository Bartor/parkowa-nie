import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:provider/provider.dart';

class StatisitcsPage extends StatefulWidget {
  StatisitcsPage({Key key}) : super(key: key);

  @override
  _StatisitcsPageState createState() => _StatisitcsPageState();
}

class _StatisitcsPageState extends State<StatisitcsPage> {
  Map<dynamic, Report> reports = {};

  @override
  initState() {
    super.initState();

    reports = Provider.of<DatabaseService>(context, listen: false).reports;
  }

  @override
  Widget build(BuildContext context) {}
}
