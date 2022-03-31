import 'package:darwin_scuba_dive/src/model/autocomplete_model.dart';
import 'package:darwin_scuba_dive/src/model/reservas_model.dart';
import 'package:darwin_scuba_dive/src/utils/logic_ventas.dart';
import 'package:flutter/material.dart';

class VentasProvider extends ChangeNotifier {
  DateTime _dateVenta = DateTime.now();

  DateTime get dateVenta => _dateVenta;
  set dateVenta(DateTime value) {
    _dateVenta = value;
    notifyListeners();
  }

  String _dateDaily = LogicVentas().getDateTimeNow().toString();
  String get dateDaily => _dateDaily;
  set dateDaily(String value) {
    _dateDaily = value;
    notifyListeners();
  }

  bool _pagado = false;
  bool get pagado => _pagado;
  set pagado(bool value) {
    _pagado = value;
    notifyListeners();
  }
  String _edad = "";
  String get edad => _edad;
  set edad(String value) {
    _edad = value;
    notifyListeners();
  }
  int _initialValue = 25;
  int get initialValue => _initialValue;
  set initialValue(int value) {
    _initialValue = value;
    notifyListeners();
  }
  bool _dropdownValueChange = false;
  bool get dropdownValueChange => _dropdownValueChange;
  set dropdownValueChange(bool value){
    _dropdownValueChange = value;
    //notifyListeners();
  }
  ReservasModel _reservasModel = ReservasModel(
      id: "NA",
      ruta: "SC-SX",
      referencia: "NA",
      proveedor: "NA",
      cedula: "NA",
      telefono: "NA",
      status: "Permanente",
      nacionalidad: "NA",
      observacion: "NA",
      fViaje: LogicVentas().getDateTimeNow().toString(),
      fReserva: LogicVentas().getDateTimeNow().toString(),
      edad: 0,
      precio: 25,
      pagado: false);
  ReservasModel get reservasModel => _reservasModel;
  set reservasModel(ReservasModel value) {
    _reservasModel = value;
  }
  AutocompleteUser _autocompleteUser = AutocompleteUser(
      cedula: '',
      edad: 0,
      nacionalidad: '',
      referencia: '',
      status: '',
      register: 0,
  );
  AutocompleteUser get autocompleteUser => _autocompleteUser;
  set autocompleteUser(AutocompleteUser value) {
    _autocompleteUser = value;
    print('autocompleteUser: ${_autocompleteUser.cedula}');
    notifyListeners();
  }

}

