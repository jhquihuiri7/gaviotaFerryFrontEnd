import 'package:flutter/material.dart';
class BoardingPassFooterWidget extends StatelessWidget {
  const BoardingPassFooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recomendaciones", style: TextStyle(color: Colors.red)),
        Text("Las condiciones para la transportación de pasajeros y equipaje son:", style: TextStyle(color: Colors.black87)),
        _texto("   - Cada pasajero puede llevar 1 mochila de mano y 1 maleta de 23kg."),
        _texto("   - Si el pasajero no viaja deberá informar a la agencia operadora donde compró su ticket con 48"),
        _texto("     horas de anticipación o perderá su valor."),
        _texto("   - Se recomienda estar 40 minutos antes de la hora de salida."),
        _texto("   - En caso de retraso del pasajero a la hora de salida, la embarcación no se responsabiliza por la"),
        _texto("     pérdida del viaje."),
      ],
    );
  }
  Text _texto (String text){
    return Text(text, style: TextStyle(color: Colors.grey));
  }
}
