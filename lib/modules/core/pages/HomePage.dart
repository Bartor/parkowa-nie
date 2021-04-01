import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/history/views/HistoricListView.dart';
import 'package:parkowa_nie/modules/report/views/ReportSummaryView.dart';
import 'package:parkowa_nie/modules/settings/views/SettingsView.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(initialPage: 1, keepPage: true);

  Widget _buildPageView() => PageView(
        physics: BouncingScrollPhysics(),
        controller: _controller,
        children: [HistoricListView(), ReportSummaryView(), SettingsView()],
      );

  void _goToPage(int page) {
    _controller.animateToPage(page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('parkowaNIE'),
        ),
        body: _buildPageView(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _goToPage(1),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 4.0,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => _goToPage(0),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => _goToPage(2),
                ),
              ],
            )));
  }
}
