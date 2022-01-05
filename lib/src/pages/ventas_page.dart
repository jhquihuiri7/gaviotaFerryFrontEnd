import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:flutter/material.dart';

class VentasPage extends StatelessWidget {
  const VentasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(

        title: Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const Center(
          child: VentasWindowWidget()
      ),
    );
  }
}
