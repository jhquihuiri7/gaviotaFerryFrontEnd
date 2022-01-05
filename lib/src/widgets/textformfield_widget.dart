import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class TextFormFieldWidget extends StatefulWidget {
  final double width;
  final String text;

  const TextFormFieldWidget({required this.width, required this.text});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ventasProvider = Provider.of<VentasProvider>(context);
    return SizedBox(
        child: TextFormField(
          controller: controller,
          onChanged: (value){
            int? age = int.tryParse(controller.text);
            ventasProvider.edad = (controller.text == null) ? "" : (controller.text == "") ? "" : controller.text;
            if (age != null) {
              if (age < 3) {
                ventasProvider.initialValue = 0;
              }else if (age > 11 && age < 65) {
                ventasProvider.initialValue = 25;
              }else {
                ventasProvider.initialValue = 15;
              }
            }
          },
          onSaved: (value){
            print(value);
            if (widget.text == "Referencia"){
              ventasProvider.reservasModel.referencia = (value == null) ? "NA" : (value == "") ? "NA" : value;
            }else if (widget.text == "D. Identidad"){
              ventasProvider.reservasModel.cedula = (value == null) ? "NA" : (value == "") ? "NA" : value;
            }else if (widget.text == "Teléfono"){
              ventasProvider.reservasModel.telefono = (value == null) ? "NA" : (value == "") ? "NA" : value;
            }else if (widget.text == "Proveedor"){
              ventasProvider.reservasModel.proveedor = (value == null) ? "NA" : (value == "") ? "NA" : value;
            }else if (widget.text == "Edad"){
              int? edad= int.tryParse(value!);
              ventasProvider.reservasModel.edad = (edad == null) ? 0 : edad;
            }else if (widget.text == "Nacionalidad"){
              ventasProvider.reservasModel.nacionalidad = (value == null) ? "NA" : (value == "") ? "NA" : value;
            }else if (widget.text == "Observaciones"){
              ventasProvider.reservasModel.observacion = (value == null) ? "NA" : (value == "") ? "NA" : value;
            }
            controller.text = "";
          },
          decoration: InputDecoration(
            label: Text(widget.text),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        width:widget.width,
        height: 35,
    );
  }
}
