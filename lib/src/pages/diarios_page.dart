import 'package:darwin_scuba_dive/src/api/generate_pdf.dart';
import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:darwin_scuba_dive/src/widgets/colum_generator_daily_widget.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../api/generate_pdf_internal.dart';
class DiariosPage extends StatelessWidget {
  const DiariosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ventasProvider = Provider.of<VentasProvider>(context);
    print(ventasProvider.dateDaily);
    String standarizeDate (String date){
      DateTime dateTimeNow = DateTime.parse("${DateTime.now().year}${(DateTime.now().month< 10)?0:""}${DateTime.now().month}${(DateTime.now().day< 10)?0:""}${DateTime.now().day}");
      if (dateTimeNow.microsecondsSinceEpoch % 86400000000 / 86400000000 == 0.25){
        return (int.parse(date) + 3600000000).toString();
      }else {
        return date;
      }
    }
    Widget _web = FabCircularMenu(
        fabOpenIcon: const Icon(Icons.print, color: Colors.white,),
        fabCloseIcon: const Icon(Icons.close, color: Colors.white),
        ringColor: Theme.of(context).primaryColor.withOpacity(0.3),
        ringDiameter: 300,
        children: <Widget>[
          FloatingActionButton(child: const Text("AM", style: TextStyle(color: Colors.black),),onPressed: (){PdfInvoiceApi().generate("AM",standarizeDate(ventasProvider.dateDaily), context);}, backgroundColor:Colors.white),
          FloatingActionButton(child: const Text("PM", style: TextStyle(color: Colors.black),),onPressed: (){PdfInvoiceApi().generate("PM",standarizeDate(ventasProvider.dateDaily), context);}, backgroundColor:Colors.white),
          FloatingActionButton(child: const Icon(Icons.monetization_on_outlined, color: Colors.black,),onPressed: (){PdfInvoiceApiInternal().generate(standarizeDate(ventasProvider.dateDaily), context);}, backgroundColor:Colors.white)
        ]
    );
    return Scaffold(
      drawer: DrawerWidget(),
      floatingActionButton: _web,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ColumnGeneratorDailyWidget(),
    );
  }
}