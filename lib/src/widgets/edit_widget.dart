import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';

class EditWidget {
  void showAlert(BuildContext context, ReservasModel element){
    final dateController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    Alert(
        context: context,
        title: "Edidar Usuario",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Referencia',
                ),
                onSaved: (value){
                  if (value != "" && value != null){
                    element.referencia = value;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: 'Proveedor',
                ),
                onSaved: (value){
                  if (value != "" && value != null){
                    element.proveedor = value;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.menu_open_sharp),
                  labelText: 'Cédula',
                ),
                onSaved: (value){
                  if (value != "" && value != null){
                    element.cedula = value;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.workspaces_filled),
                  labelText: 'Edad',
                ),
                onSaved: (value){
                  if (value != "" && value != null){
                    int? edad = int.tryParse(value);
                    if (edad != null){
                      element.edad= edad;
                    }
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.monetization_on_outlined),
                  labelText: 'Precio',
                ),
                onSaved: (value){
                  if (value != "" && value != null){
                    int? precio = int.tryParse(value);
                    if (precio != null){
                      element.precio= precio;
                    }
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.location_on_outlined),
                  labelText: 'País',
                ),
                onSaved: (value){
                  if (value != "" && value != null){
                    element.nacionalidad = value;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.note_outlined),
                  labelText: 'Observación',
                ),
                onSaved: (value){
                  if (value != "" && value != null){
                    element.observacion = value;
                  }
                },
              ),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.note_outlined),
                  labelText: 'Fecha',
                ),
                onSaved: (value){

                },
                onTap: ()async{
                  await DatePickerFunction().datePicker(context, "updateDaily");
                  final ventasProvider = Provider.of<VentasProvider>(context, listen: false);
                  element.fViaje = ventasProvider.updateDateDaily;
                  dateController.text = StandarizeDate().getStringDate(DateTime.fromMicrosecondsSinceEpoch(int.parse(element.fViaje)));
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print(element.precio);
                print(element.nacionalidad);
                print(element.referencia);
                LogicDaily().updateData(element);
              }
              Navigator.pushReplacementNamed(context, "diarios");
            },
            child: const Text(
              "Guardar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
