import 'package:darwin_scuba_dive/src/utils/varibles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/export_widgets.dart';

class ConfiguracionPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(capitanName);
        },
        child: Icon(Icons.settings),
      ),
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                children: [
                  Text("Configura el nombre del Capitán", style: TextStyle(fontSize: 30),),
                ],
              ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Container(
                    width: 300,
                    height:40,
                    child: TextFormField(
                        decoration: InputDecoration(
                          label: Text("Nombre del Capitán"),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onSaved: (value)async{
                          if (value != "" || value != null)  {
                              Uri url = Uri.parse("https://gaviota-ferry-backend.uc.r.appspot.com/updateCap/"+value!.toUpperCase());
                              http.Response response = await http.post(url);
                              Navigator.pushReplacementNamed(context, "diarios");
                          }
                        }
                    ),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                      onPressed: (){
                        _formKey.currentState!.save();
                      },
                      child: Text("Guardar"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
