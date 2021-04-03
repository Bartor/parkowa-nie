import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/pages/HomePage.dart';
import 'package:parkowa_nie/modules/core/services/LocationService.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => DatabaseService(),
      ),
      ChangeNotifierProvider(create: (_) => LocationService())
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'parkowaNIE',
      theme:
          ThemeData(primarySwatch: Colors.indigo, brightness: Brightness.light),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.indigo)
              .copyWith(
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo.shade200)),
            labelStyle: TextStyle(color: Colors.indigo.shade200),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.indigo.shade200, width: 2))),
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}
