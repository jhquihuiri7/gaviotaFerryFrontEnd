import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:flutter/material.dart';
class ReportesPage extends StatelessWidget {
  const ReportesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Text("Paginas de Reportes"),
      ),
    );
  }
}
