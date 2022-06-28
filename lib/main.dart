import 'dart:convert';

import 'package:darwin_scuba_dive/src/pages/boarding_pass_page.dart';
import 'package:darwin_scuba_dive/src/pages/configuracion_page.dart';
import 'package:darwin_scuba_dive/src/pages/diarios_page.dart';
import 'package:darwin_scuba_dive/src/pages/login_page.dart';
import 'package:darwin_scuba_dive/src/pages/reportes_page.dart';
import 'package:darwin_scuba_dive/src/pages/ventas_page.dart';
import 'package:darwin_scuba_dive/src/provider/utils_provider.dart';
import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/utils/varibles.dart';
import 'package:http/http.dart' as http;
void main() async{
  Uri urlCap = Uri.parse("https://gaviota-ferry-backend.uc.r.appspot.com/getCap");

  http.Response response = await http.get(urlCap);
  capitanName = jsonDecode(response.body)["Name"];
  print(capitanName);
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
        ChangeNotifierProvider(create: (_)=>UtilsProvider()),
        //ChangeNotifierProvider(create: (_)=>Variables())
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
          "configuracion": (_)=>ConfiguracionPage(),
        },
        theme: ThemeData(
          primaryColor: const Color(0xffff0000),
        ),
      ),
    );
  }
}
