import 'package:flutter/material.dart';
class CellWidget extends StatelessWidget {
  final double cellWidth;
  final String value;
  final String type;
  CellWidget({required this.cellWidth, required this.value, required this.type});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: size.width * cellWidth,
      child: Text(
        value,
        style: TextStyle(
            fontWeight: (this.type == "col") ? FontWeight.w600 : FontWeight.normal),
      ),
    );
  }
}
