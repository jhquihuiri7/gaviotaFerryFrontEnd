import 'package:darwin_scuba_dive/src/provider/utils_provider.dart';
import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:darwin_scuba_dive/src/utils/logic_daily.dart';
import 'package:darwin_scuba_dive/src/utils/logic_ventas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class VentasWindowWidget extends StatefulWidget {
  const VentasWindowWidget({Key? key}) : super(key: key);

  @override
  State<VentasWindowWidget> createState() => _VentasWindowWidgetState();
}
class _VentasWindowWidgetState extends State<VentasWindowWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ventasProvider = Provider.of<VentasProvider>(context);
    final utilsProvider = Provider.of<UtilsProvider>(context);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Ingrese una nueva reserva", style: TextStyle(fontSize: 30)),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      style: Style().datesStyle,
                      onPressed: (){
                        DatePickerFunction().datePicker(context, "venta");
                      },
                      child: Text(DateFormat("dd/MM/yyyy").format(ventasProvider.dateVenta), style: Style().dateStyle,)
                  ),
                  const SizedBox(width: 40,),
                  const DropDownWidget(option: "ruta",),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  TextFormFieldWidget(width: 300, text: "Referencia",),
                  SizedBox(width: 40),
                  TextFormFieldWidget(width: 150, text: "D. Identidad"),
                  SizedBox(width: 40),
                  TextFormFieldWidget(width: 150, text: "Teléfono"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const[
                  TextFormFieldWidget(width: 300, text: "Proveedor"),
                  SizedBox(width: 40),
                  TextFormFieldWidget(width: 150, text: "Edad"),
                  SizedBox(width: 40),
                  DropDownWidget(option: "precio",),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  TextFormFieldWidget(width: 150, text: "Nacionalidad"),
                  SizedBox(width: 40),
                  DropDownWidget(option: "status",),
                  SizedBox(width: 40),
                  TextFormFieldWidget(width: 380, text: "Observaciones"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          utilsProvider.addUserButton = false;
                          _formKey.currentState!.save();
                          Uri url = LogicVentas().addUserUrl(context);
                          http.Response response = await http.post(url);
                          ventasProvider.dateVenta = DateTime.now();
                          ventasProvider.reservasModel.fViaje = LogicVentas().getDateTimeNow().toString();
                          if (response.statusCode == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Reserva ingresada correctamente')),
                            );
                          }else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No se pudo ingresar usuario. Problemas de conexion')),
                            );
                          }
                          utilsProvider.addUserButton = true;
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                      child: (utilsProvider.addUserButton) ? Text("Agregar pasajero") : Container(height: 15,width: 15, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 3,))
                  ),
                  SizedBox(width: 20),
                  Switch(
                      value: ventasProvider.pagado,
                      onChanged: (value){
                        ventasProvider.pagado = value;
                        ventasProvider.reservasModel.pagado = value;
                      }
                  ),
                  Text("¿Pagado?")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
