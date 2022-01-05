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

    Uri url = Uri.parse("http://localhost:8080/getDailyData/$time/${ventasProvider.dateDaily}");
    http.Response response = await http.get(url);

    final List<dynamic> resp = jsonDecode(response.body);
    resp.forEach((element) {
      final ReservasModel reservas = ReservasModel.fromJson(element);
      list.add(reservas);
    });
    print(list);
    return list;
  }
  Future updateData (ReservasModel item)async {
    Uri url = Uri.parse("http://localhost:8080/updateUser/${item.id}/${item.fViaje}/"+
        "${item.ruta}/${item.referencia}/${item.proveedor}/${item.cedula}/${item.telefono}/"+
        "${item.status}/${item.nacionalidad}/${item.observacion}/${item.fReserva}/${item.edad}/"+
        "${item.precio}/${item.pagado}");
    print(url);
    http.Response response = await http.post(url);
    print(response.statusCode);
  }
  Future<List<ReservasModel>> getAMDailyData (BuildContext context, String time)async {
    final ventasProvider = Provider.of<VentasProvider>(context);
    List<ReservasModel> list = [];

    Uri url = Uri.parse("http://localhost:8080/getDailyData/$time/${ventasProvider.dateDaily}");
    http.Response response = await http.get(url);

    final List<dynamic> resp = jsonDecode(response.body);
    resp.forEach((element) {
      final ReservasModel reservas = ReservasModel.fromJson(element);
      list.add(reservas);
    });
    print(list);
    return list;
  }
  Future<List<ReservasModel>> getPMDailyData (BuildContext context)async {
    final ventasProvider = Provider.of<VentasProvider>(context);
    List<ReservasModel> list = [];

    Uri url = Uri.parse("http://localhost:8080/getDailyData/${ventasProvider.dateDaily}");
    http.Response response = await http.get(url);

    final List<dynamic> resp = jsonDecode(response.body);
    resp.forEach((element) {
      final ReservasModel reservas = ReservasModel.fromJson(element);
      list.add(reservas);
    });
    print(list);
    return list;
  }

}