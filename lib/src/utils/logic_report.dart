import 'dart:convert';

import 'package:darwin_scuba_dive/src/model/reporte_model.dart';
import 'package:darwin_scuba_dive/src/model/reservas_model.dart';
import 'package:darwin_scuba_dive/src/utils/logic_ventas.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'export_widgets.dart';
class LogicReport {
  Future<ReporteModel> getReport (BuildContext context, int begin, int end)async {
    Uri url = Uri.parse("https://gaviota-ferry-backend.uc.r.appspot.com/report/$begin/$end");
    http.Response response = await http.post(url);
    ReporteModel reporte;
    if (response.body.length > 5) {
      final Map<String,dynamic> resp = jsonDecode(response.body);
      reporte = ReporteModel.fromJson(resp);
      print(reporte.ventas);
    }else {
      reporte = ReporteModel(ventas: 0, facturado: 0, recuperado: 0, recuperar: 0, detalle: []);
    }
    return reporte;
  }
  Future<String> updateReport (BuildContext context, String id)async {
    Uri url = Uri.parse("https://gaviota-ferry-backend.uc.r.appspot.com/reportUpdate/$id");
    print(url);
    http.Response response = await http.post(url);

    return "OK";
  }

}