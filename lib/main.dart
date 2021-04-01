import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/pages/HomePage.dart';
import 'package:parkowa_nie/modules/core/services/ReportsService.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      // This provider loads a database from the filesystem, can't be lazy for smooth ux
      Provider(
        create: (_) => ReportsService(),
        lazy: false,
      )
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'parkowaNIE',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}
