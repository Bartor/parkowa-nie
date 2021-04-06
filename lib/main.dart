import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parkowa_nie/modules/core/model/Offence.dart';
import 'package:parkowa_nie/modules/core/pages/HomePage.dart';
import 'package:parkowa_nie/modules/core/services/LocationService.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/services/ThemeService.dart';
import 'package:provider/provider.dart';

import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'modules/core/model/ContactInformation.dart';
import 'modules/core/model/Report.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ContactInformationAdapter());
  Hive.registerAdapter(ReportAdapter());
  Hive.registerAdapter(OffenceTypeAdapter());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => DatabaseService(),
      ),
      ChangeNotifierProvider(create: (_) => LocationService()),
      ChangeNotifierProvider(
        create: (_) => ThemeService(),
      )
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pl'),
        const Locale('en'),
      ],
      title: 'parkowaNIE',
      theme: ThemeService.lightTheme,
      darkTheme: ThemeService.darkTheme,
      themeMode: themeService.themeMode,
      home: I18n(
        child: HomePage(),
      ),
    );
  }
}
