import 'dart:convert';

import 'package:darwin_scuba_dive/src/model/reservas_model.dart';
import 'package:darwin_scuba_dive/src/utils/logic_ventas.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'export_widgets.dart';
class LogicDaily {
  Future<List<ReservasModel>> getDailyData (BuildContext context, String time)async {
    final ventasProvider = Provider.of<VentasProvider>(context, listen: false);
    List<ReservasModel> list = [];
    Uri url = Uri.parse("https://gaviota-ferry-backend.uc.r.appspot.com/getDailyData/$time/${ventasProvider.dateDaily}");
    http.Response response = await http.get(url);
    if (response.body.length > 5) {
      final List<dynamic> resp = jsonDecode(response.body);
      resp.forEach((element) {
        final ReservasModel reservas = ReservasModel.fromJson(element);
        list.add(reservas);
      });
    }
    return list;
  }
  Future updateData (ReservasModel item)async {
    Uri url = Uri.parse("https://gaviota-ferry-backend.uc.r.appspot.com/updateUser/${item.id}/${item.fViaje}/"+
        "${item.ruta}/${(item.referencia == "" ? "NA" : item.referencia)}/${(item.proveedor == "") ? "NA" : item.proveedor}/"+
        "${(item.cedula == "") ? "NA" : item.cedula}/${(item.telefono == "") ? "NA" : item.telefono}/"+
        "${item.status}/${(item.nacionalidad == "") ? "NA" : item.nacionalidad}/${(item.observacion == "") ? "NA" : item.observacion}/"+
        "${item.fReserva}/${item.edad}/"+
        "${item.precio}/${item.pagado}");
    print(url);
    http.Response response = await http.post(url);
    print(response.statusCode);
  }
}