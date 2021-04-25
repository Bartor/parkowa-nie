import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parkowa_nie/modules/core/model/Offence.dart';
import 'package:parkowa_nie/modules/core/pages/HomePage.dart';
import 'package:parkowa_nie/modules/core/services/AnalyticsService.dart';
import 'package:parkowa_nie/modules/core/services/CitiesService.dart';
import 'package:parkowa_nie/modules/core/services/LocationService.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/services/ThemeService.dart';
import 'package:provider/provider.dart';

import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'modules/core/model/ContactInformation.dart';
import 'modules/core/model/Report.dart';

void main() async {
  await Future.wait([Hive.initFlutter(), Firebase.initializeApp()]);

  Hive.registerAdapter(ContactInformationAdapter());
  Hive.registerAdapter(ReportAdapter());
  Hive.registerAdapter(OffenceTypeAdapter());

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => DatabaseService(),
      ),
      ChangeNotifierProvider(
        create: (_) => ThemeService(),
      ),
      Provider(create: (_) => LocationService()),
      Provider(create: (_) => AnalyticsService()),
      Provider(create: (_) => CitiesService(), lazy: false),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final analytics =
        Provider.of<AnalyticsService>(context, listen: false).analytics;

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
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
