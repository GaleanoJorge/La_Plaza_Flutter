import 'dart:io';

import 'package:flutter/material.dart';
import 'package:la_plaza/src/pages/detail/detail_page.dart';
import 'package:la_plaza/src/pages/home/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:la_plaza/src/utils/values.dart' as utils;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    HttpOverrides.global = MyHttpOverrides();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('es', 'ES'), // Español
      ],
      navigatorKey: navigatorKey,
      title: utils.Values.titleApp,
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        primaryColor: Colors.indigo,
      ),
      routes: {
        '/home' : (context) => Home(),
        '/detail' : (context) => Detail(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}