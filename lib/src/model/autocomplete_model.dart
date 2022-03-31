// To parse this JSON data, do
//
//     final autocompleteUser = autocompleteUserFromJson(jsonString);

import 'dart:convert';

List<AutocompleteUser> autocompleteUserFromJson(String str) => List<AutocompleteUser>.from(json.decode(str).map((x) => AutocompleteUser.fromJson(x)));

String autocompleteUserToJson(List<AutocompleteUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AutocompleteUser {
  AutocompleteUser({
    required this.referencia,
    required this.cedula,
    required this.status,
    required this.nacionalidad,
    required this.edad,
    required this.register,
  });

  String referencia;
  String cedula;
  String status;
  String nacionalidad;
  int edad;
  int register;

  factory AutocompleteUser.fromJson(Map<String, dynamic> json) => AutocompleteUser(
    referencia: json["Referencia"],
    cedula: json["Cedula"],
    status: json["Status"],
    nacionalidad: json["Nacionalidad"],
    edad: json["Edad"],
    register: json["DateRegister"],
  );

  Map<String, dynamic> toJson() => {
    "Referencia": referencia,
    "Cedula": cedula,
    "Status": status,
    "Nacionalidad": nacionalidad,
    "Edad": edad,
    "DateRegister": register,
  };
}
