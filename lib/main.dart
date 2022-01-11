import 'package:darwin_scuba_dive/src/pages/diarios_page.dart';
import 'package:darwin_scuba_dive/src/pages/login_page.dart';
import 'package:darwin_scuba_dive/src/pages/reportes_page.dart';
import 'package:darwin_scuba_dive/src/pages/ventas_page.dart';
import 'package:darwin_scuba_dive/src/provider/utils_provider.dart';
import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>VentasProvider()),
        ChangeNotifierProvider(create: (_)=>UtilsProvider())
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const[
          Locale('es', 'EC'),
        ],
        title: 'Darwin Scuba Dive',
        debugShowCheckedModeBanner: false,
        initialRoute: "ventas",
        routes: {
          "login":(_)=>LoginPage(),
          "ventas":(_)=>VentasPage(),
          "diarios":(_)=>DiariosPage(),
          "reportes":(_)=>ReportesPage(),
        },
        theme: ThemeData(
          primaryColor: const Color(0xffff0000),
        ),
      ),
    );
  }
}
