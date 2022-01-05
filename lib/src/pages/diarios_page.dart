import 'dart:html';

import 'package:darwin_scuba_dive/src/api/generate_pdf.dart';
import 'package:darwin_scuba_dive/src/api/pdf_api.dart';
import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:darwin_scuba_dive/src/utils/logic_daily.dart';
import 'package:darwin_scuba_dive/src/widgets/colum_generator_daily_widget.dart';
import 'package:darwin_scuba_dive/src/widgets/daily_grid_widget.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
class DiariosPage extends StatelessWidget {
  const DiariosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ventasProvider = Provider.of<VentasProvider>(context);
    return Scaffold(
      drawer: DrawerWidget(),
      floatingActionButton: FabCircularMenu(
          fabOpenIcon: const Icon(Icons.print, color: Colors.white,),
          fabCloseIcon: const Icon(Icons.close, color: Colors.white),
          ringColor: Theme.of(context).primaryColor.withOpacity(0.3),
          ringDiameter: 300,
          children: <Widget>[
          FloatingActionButton(child: const Text("AM", style: TextStyle(color: Colors.black),),onPressed: (){PdfInvoiceApi().generate("AM",ventasProvider.dateDaily, context);}, backgroundColor:Colors.white),
          FloatingActionButton(child: const Text("PM", style: TextStyle(color: Colors.black),),onPressed: (){PdfInvoiceApi().generate("PM",ventasProvider.dateDaily, context);}, backgroundColor:Colors.white)
          ]
      ),
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ColumnGeneratorDailyWidget(),
    );
  }
}