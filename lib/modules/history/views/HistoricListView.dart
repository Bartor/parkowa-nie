import 'package:flutter/cupertino.dart';
import 'package:parkowa_nie/modules/core/services/ReportsService.dart';
import 'package:provider/provider.dart';

class HistoricListView extends StatefulWidget {
  @override
  _HistoricListViewState createState() => _HistoricListViewState();
}

class _HistoricListViewState extends State<HistoricListView> {
  @override
  Widget build(BuildContext context) {
    final message =
        Provider.of<ReportsService>(context, listen: false).getCoolMesage();

    return Center(
      child: FutureBuilder(
        future: message,
        builder: (context, snapshot) =>
            snapshot.hasData ? Text(snapshot.data) : Text('Loading...'),
      ),
    );
  }
}
