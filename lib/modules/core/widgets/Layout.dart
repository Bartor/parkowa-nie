import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  final List<Widget> actions;
  final Widget body;
  Layout({Key key, this.actions = const [], this.body});

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
        actions: actions,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: body,
      ),
    );
  }
}
