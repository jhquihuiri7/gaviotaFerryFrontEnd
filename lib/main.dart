import 'package:darwin_scuba_dive/src/pages/boarding_pass_page.dart';
import 'package:darwin_scuba_dive/src/pages/diarios_page.dart';
import 'package:darwin_scuba_dive/src/pages/login_page.dart';
import 'package:darwin_scuba_dive/src/pages/reportes_page.dart';
import 'package:darwin_scuba_dive/src/pages/ventas_page.dart';
import 'package:darwin_scuba_dive/src/provider/utils_provider.dart';
import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
//import 'dart:io';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  //  (Platform.isAndroid || Platform.isIOS)? DeviceOrientation.landscapeLeft: DeviceOrientation.portraitUp,
  //  (Platform.isAndroid || Platform.isIOS)? DeviceOrientation.landscapeRight: DeviceOrientation.portraitDown,
  //]).then((value) => runApp(MyApp()));
  runApp(MyApp());
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
        title: 'Ferry Gaviota',
        debugShowCheckedModeBanner: false,
        initialRoute: "diarios",
        routes: {
          "login":(_)=>LoginPage(),
          "ventas":(_)=>VentasPage(),
          "diarios":(_)=>DiariosPage(),
          "reportes":(_)=>ReportesPage(),
          "ticket":(_)=>BoardingPassPage(),
        },
        theme: ThemeData(
          primaryColor: const Color(0xffff0000),
        ),
      ),
    );
  }
}
