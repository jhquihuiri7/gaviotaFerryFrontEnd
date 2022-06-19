import 'dart:convert';

import 'package:darwin_scuba_dive/src/model/autocomplete_model.dart';
import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LogicVentas {
  Future<List<AutocompleteUser>> GetAutocompleteUser () async{

    Uri url = Uri.parse("https://gaviota-ferry-backend.uc.r.appspot.com/autocompleteUser");
    http.Response response = await http.get(url);
    return autocompleteUserFromJson(response.body);
  }
  
  Uri addUserUrl (BuildContext context){
    final ventasProvider = Provider.of<VentasProvider>(context, listen: false);
    return Uri.parse(
        "https://gaviota-ferry-backend.uc.r.appspot.com/addUser/${ventasProvider.reservasModel.fViaje}/"+
            "${ventasProvider.reservasModel.ruta}/${ventasProvider.reservasModel.referencia}/"+
            "${ventasProvider.reservasModel.proveedor}/${ventasProvider.reservasModel.cedula}/"+
            "${ventasProvider.reservasModel.telefono}/${ventasProvider.reservasModel.status}/"+
            "${ventasProvider.reservasModel.nacionalidad}/${ventasProvider.reservasModel.observacion}/"+
            "${ventasProvider.reservasModel.fReserva}/${ventasProvider.reservasModel.edad}/"+
            "${ventasProvider.reservasModel.precio}/${ventasProvider.reservasModel.pagado}");
  }
  int getDateTimeNow(){

    DateTime dateTimeNow = DateTime.parse("${DateTime.now().year}${(DateTime.now().month< 10)?0:""}${DateTime.now().month}${(DateTime.now().day< 10)?0:""}${DateTime.now().day}");
       //return (dateTimeNow.millisecondsSinceEpoch - (dateTimeNow.hour * 3600000) - (dateTimeNow.minute * 60000) - (dateTimeNow.second * 1000) - dateTimeNow.millisecond) * 1000;
    if (dateTimeNow.microsecondsSinceEpoch % 86400000000 / 86400000000 == 0.25){
      return dateTimeNow.microsecondsSinceEpoch - 3600000000;
    }else {
      return dateTimeNow.microsecondsSinceEpoch;
    }
  }
}
