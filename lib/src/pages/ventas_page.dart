import 'package:darwin_scuba_dive/src/model/autocomplete_model.dart';
import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:darwin_scuba_dive/src/utils/logic_ventas.dart';
import 'package:flutter/material.dart';

class VentasPage extends StatelessWidget {
  const VentasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //LogicVentas().GetAutocompleteUser();
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(

        title: Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
          child: FutureBuilder(
            future: LogicVentas().GetAutocompleteUser(),
            builder: (BuildContext context, AsyncSnapshot<List<AutocompleteUser>> snapshot){
              if (snapshot.hasData){
                return VentasWindowWidget(users: snapshot.data!);
              }
              return Container();
            },
          )
      ),
    );
  }
}
