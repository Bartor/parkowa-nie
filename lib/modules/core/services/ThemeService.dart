import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeService extends ChangeNotifier {
  Box _userBox;
  bool _initialized = false;

  ThemeService() {
    _init();
  }

  Future<void> _init() async {
    if (_initialized == false) {
      _userBox = await Hive.openBox('user');

      _userBox.watch().listen((event) {
        if (event.key == 'dark_theme') {
          themeMode = event.value ? ThemeMode.dark : ThemeMode.light;
          notifyListeners();
        }
      });
    }
  }

  Future<void> toggleTheme({bool dark}) async {
    _userBox.put('dark_theme', dark);
  }

  ThemeMode themeMode = ThemeMode.light;

  static ThemeData darkTheme =
      ThemeData(primarySwatch: Colors.indigo, brightness: Brightness.dark)
          .copyWith(
    inputDecorationTheme: InputDecorationTheme(
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo.shade200)),
        labelStyle: TextStyle(color: Colors.indigo.shade200),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo.shade200, width: 2))),
  );
  static ThemeData lightTheme =
      darkTheme.copyWith(brightness: Brightness.light);
}
