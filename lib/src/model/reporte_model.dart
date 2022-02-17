// To parse this JSON data, do
//
//     final reporteModel = reporteModelFromJson(jsonString);

import 'dart:convert';

ReporteModel reporteModelFromJson(String str) => ReporteModel.fromJson(json.decode(str));

String reporteModelToJson(ReporteModel data) => json.encode(data.toJson());

class ReporteModel {
  ReporteModel({
    required this.ventas,
    required this.facturado,
    required this.recuperado,
    required this.recuperar,
    required this.detalle,
  });

  int ventas;
  int facturado;
  int recuperado;
  int recuperar;
  List<Detalle> detalle;

  factory ReporteModel.fromJson(Map<String, dynamic> json) => ReporteModel(
    ventas: json["Ventas"],
    facturado: json["Facturado"],
    recuperado: json["Recuperado"],
    recuperar: json["Recuperar"],
    detalle: List<Detalle>.from(json["Detalle"].map((x) => Detalle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Ventas": ventas,
    "Facturado": facturado,
    "Recuperado": recuperado,
    "Recuperar": recuperar,
    "Detalle": List<dynamic>.from(detalle.map((x) => x.toJson())),
  };
}

class Detalle {
  Detalle({
    required this.proveedor,
    required this.detallePasajero,
    required this.total,
  });

  String proveedor;
  List<DetallePasajero> detallePasajero;
  int total;

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
    proveedor: json["Proveedor"],
    detallePasajero: List<DetallePasajero>.from(json["DetallePasajero"].map((x) => DetallePasajero.fromJson(x))),
    total: json["Total"],
  );

  Map<String, dynamic> toJson() => {
    "Proveedor": proveedor,
    "DetallePasajero": List<dynamic>.from(detallePasajero.map((x) => x.toJson())),
    "Total": total,
  };
}

class DetallePasajero {
  DetallePasajero({
    required this.id,
    required this.fViaje,
    required this.ruta,
    required this.referencia,
    required this.precio,
  });
  String id;
  String fViaje;
  String ruta;
  String referencia;
  int precio;

  factory DetallePasajero.fromJson(Map<String, dynamic> json) => DetallePasajero(
    id:json["Id"],
    fViaje: json["FViaje"],
    ruta: json["Ruta"],
    referencia: json["Referencia"],
    precio: json["Precio"],
  );

  Map<String, dynamic> toJson() => {
    "Id":id,
    "FViaje": fViaje,
    "Ruta": ruta,
    "Referencia": referencia,
    "Precio": precio,
  };
}
