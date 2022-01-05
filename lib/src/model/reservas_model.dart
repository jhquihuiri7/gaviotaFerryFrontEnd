// To parse this JSON data, do
//
//     final reservasModel = reservasModelFromJson(jsonString);

import 'dart:convert';

ReservasModel reservasModelFromJson(String str) => ReservasModel.fromJson(json.decode(str));

String reservasModelToJson(ReservasModel data) => json.encode(data.toJson());

class ReservasModel {
  ReservasModel({
    required this.id,
    required this.ruta,
    required this.referencia,
    required this.proveedor,
    required this.cedula,
    required this.telefono,
    required this.status,
    required this.nacionalidad,
    required this.observacion,
    required this.fViaje,
    required this.fReserva,
    required this.edad,
    required this.precio,
    required this.pagado,
  });

  String id;
  String ruta;
  String referencia;
  String proveedor;
  String cedula;
  String telefono;
  String status;
  String nacionalidad;
  String observacion;
  String fViaje;
  String fReserva;
  int edad;
  int precio;
  bool pagado;

  factory ReservasModel.fromJson(Map<String, dynamic> json) => ReservasModel(
    id: json["Id"],
    ruta: json["Ruta"],
    referencia: json["Referencia"],
    proveedor: json["Proveedor"],
    cedula: json["Cedula"],
    telefono: json["Telefono"],
    status: json["Status"],
    nacionalidad: json["Nacionalidad"],
    observacion: json["Observacion"],
    fViaje: json["FViaje"],
    fReserva: json["FReserva"],
    edad: json["Edad"],
    precio: json["Precio"],
    pagado: json["Pagado"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Ruta": ruta,
    "Referencia": referencia,
    "Proveedor": proveedor,
    "Cedula": cedula,
    "Telefono": telefono,
    "Status": status,
    "Nacionalidad": nacionalidad,
    "Observacion": observacion,
    "FViaje": fViaje,
    "FReserva": fReserva,
    "Edad": edad,
    "Precio": precio,
    "Pagado": pagado,
  };
}
