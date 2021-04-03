import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/settings/pages/SettingsPage.dart';

class Layout extends StatelessWidget {
  final bool settings;
  final Widget body;
  Layout({Key key, this.settings = false, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          child:
              Text('parkowaNIE', style: Theme.of(context).textTheme.headline5),
          tag: 'bar/title',
        ),
        actions: settings
            ? [
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => SettingsPage()));
                    })
              ]
            : null,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: body,
      ),
    );
  }
}
