import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogicVentas {
  Uri addUserUrl (BuildContext context){
    final ventasProvider = Provider.of<VentasProvider>(context, listen: false);
    print(ventasProvider.reservasModel.fReserva);
    return Uri.parse(
        "http://localhost:8080/addUser/${ventasProvider.reservasModel.fViaje}/"+
            "${ventasProvider.reservasModel.ruta}/${ventasProvider.reservasModel.referencia}/"+
            "${ventasProvider.reservasModel.proveedor}/${ventasProvider.reservasModel.cedula}/"+
            "${ventasProvider.reservasModel.telefono}/${ventasProvider.reservasModel.status}/"+
            "${ventasProvider.reservasModel.nacionalidad}/${ventasProvider.reservasModel.observacion}/"+
            "${ventasProvider.reservasModel.fReserva}/${ventasProvider.reservasModel.edad}/"+
            "${ventasProvider.reservasModel.precio}/${ventasProvider.reservasModel.pagado}");
  }
  int getDateTimeNow(){
    DateTime dateTimeNow = DateTime.now();
    print(DateTime.now().millisecondsSinceEpoch - DateTime.now().millisecond);
    return (dateTimeNow.millisecondsSinceEpoch - (dateTimeNow.hour * 3600000) - (dateTimeNow.minute * 60000) - (dateTimeNow.second * 1000) - dateTimeNow.millisecond) * 1000;
  }
}
