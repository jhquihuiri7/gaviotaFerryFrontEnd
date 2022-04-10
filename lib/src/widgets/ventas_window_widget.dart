import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class VentasWindowWidget extends StatefulWidget {
  final List<AutocompleteUser> users;
  const VentasWindowWidget({required this.users});

  @override
  State<VentasWindowWidget> createState() => _VentasWindowWidgetState();
}
class _VentasWindowWidgetState extends State<VentasWindowWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerCedula = TextEditingController();
  TextEditingController _controllerProveedor = TextEditingController();
  TextEditingController _controllerEdad = TextEditingController();
  TextEditingController _controllerNacionalidad = TextEditingController();
  TextEditingController _controllerObservaciones = TextEditingController();
  TextEditingController _controllerTelefono = TextEditingController();
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
                children: [
                  //child: TextFormFieldWidget(width: 300, text: "Referencia",)
                  Autocomplete<AutocompleteUser>(
                   optionsBuilder: (TextEditingValue textEditingValue) {
                     return widget.users.where((AutocompleteUser user) =>
                         user.referencia.toLowerCase()
                             .startsWith(textEditingValue.text.toLowerCase())).toList();
                     },
                   displayStringForOption: (AutocompleteUser option) => option.referencia,
                    fieldViewBuilder: (
                        BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted
                        ) {
                      return Container(
                        width: 300,
                        height: 35,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Referencia"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          onSaved: (value){
                            ventasProvider.reservasModel.referencia = value!;
                            fieldTextEditingController.text = "";
                          },
                          onChanged: (value){
                            if (value.length < 5){
                              ventasProvider.autocompleteUser.status = "";
                            }
                          },
                        ),
                      );
                    },
                    onSelected: (AutocompleteUser selection) {
                      _controllerCedula.value = _controllerCedula.value.copyWith(text: selection.cedula);
                      _controllerEdad.value = _controllerEdad.value.copyWith(text: "${(DateTime.now().year - selection.register)+ selection.edad}");
                      _controllerProveedor.value = _controllerProveedor.value.copyWith(text: "");
                      _controllerNacionalidad.value = _controllerNacionalidad.value.copyWith(text: selection.nacionalidad);
                      _controllerObservaciones.value = _controllerObservaciones.value.copyWith(text: "");
                      _controllerTelefono.value = _controllerTelefono.value.copyWith(text: "");
                      final AutocompleteUser user = AutocompleteUser(
                        referencia: selection.referencia,
                        cedula: selection.cedula,
                        status: selection.status,
                        edad: selection.edad,
                        nacionalidad: selection.nacionalidad,
                        register: selection.register,
                      );
                      ventasProvider.autocompleteUser =  user;

                      setState(() {
                      });
                    },
                    optionsViewBuilder: (
                        BuildContext context,
                        AutocompleteOnSelected<AutocompleteUser> onSelected,
                        Iterable<AutocompleteUser> options){
                      return Align(
                        alignment: Alignment.centerLeft,

                          child: Material(
                            child: Container(
                               width: 300,
                               color: Colors.grey.withOpacity(0.8),
                               child: ListView.builder(
                                  padding: EdgeInsets.all(10.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final AutocompleteUser option = options.elementAt(index);
                                    return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: ListTile(
                                          title: Text(option.referencia,
                                            style: const TextStyle(color: Colors.white)),
                                        ),
                                    )   ;
                                  }
                              ),
                            ),
                          ),
                      );
                    },

                  ),
                  SizedBox(width: 40),
                  TextFormFieldWidget(width: 150, text: "D. Identidad", controller: _controllerCedula,),
                  SizedBox(width: 40),
                  TextFormFieldWidget(width: 150, text: "Teléfono", controller: _controllerTelefono,),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormFieldWidget(width: 300, text: "Proveedor", controller: _controllerProveedor,),
                  SizedBox(width: 40),
                  TextFormFieldWidget(width: 150, text: "Edad", controller: _controllerEdad,),
                  SizedBox(width: 40),
                  DropDownWidget(option: "precio",),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormFieldWidget(width: 150, text: "Nacionalidad", controller: _controllerNacionalidad,),
                  SizedBox(width: 40),
                  DropDownWidget(option: "status",),
                  SizedBox(width: 40),
                  TextFormFieldWidget(width: 380, text: "Observaciones", controller: _controllerObservaciones,),
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
