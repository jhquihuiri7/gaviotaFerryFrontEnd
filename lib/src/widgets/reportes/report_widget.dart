import 'dart:io';

import 'package:darwin_scuba_dive/src/model/reporte_model.dart';
import 'package:darwin_scuba_dive/src/utils/logic_report.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';

import '../../utils/export_widgets.dart';
class ReportWidget extends StatelessWidget {
  final ReporteModel reportModel;
  final int initialDate;
  final int endDate;
  ReportWidget({required this.reportModel, required this.initialDate, required this.endDate});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<Widget> widgetCobros = [];
    Widget widgetIngresosHeader = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _container(context, "Ventas", "header"),
        _container(context, "Facturado", "header"),
        _container(context, "Recuperado", "header"),
        _container(context, "Recuperar", "header"),
      ],
    );
    Widget widgetIngresos = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _container(context, reportModel.ventas.toString(), "hfeader"),
        _container(context, reportModel.facturado.toString(), "fheader"),
        _container(context, reportModel.recuperado.toString(), "hfeader"),
        _container(context, reportModel.recuperar.toString(), "headfer"),
      ],
    );

    widgetCobros.add(SizedBox(height: 30));
    widgetCobros.add(widgetIngresosHeader);
    widgetCobros.add(widgetIngresos);
    widgetCobros.add(SizedBox(height: 30));
    reportModel.detalle.forEach((element) {
      Widget detalleCobroHeader = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _containerDeuda(context, "Fecha Viaje", "header", 200),
            _containerDeuda(context, "Ruta", "header", 200),
            _containerDeuda(context, "Referencia", "header", 300),
            _containerDeuda(context, "Precio", "header", 200),
          ]
      );

      widgetCobros.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                  ),
                  child: Text(element.proveedor, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
              ),
              Text("TOTAL: ${element.total.toString()}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              IconButton(
                  onPressed: (){
                    var excel = Excel.createExcel(); // automatically creates 1 empty sheet: Sheet1
                    excel.rename('Sheet1', element.proveedor);
                    Sheet sheetObject = excel[element.proveedor];
                    List<String> dataList = ["", "DE ${element.proveedor} A GAVIOTA"];
                    sheetObject.insertRowIterables(dataList, 0);
                    sheetObject.appendRow(["Fecha Viaje", "Ruta", "Referencia", "Precio"]);
                    element.detallePasajero.forEach((detalle) {
                      sheetObject.appendRow([(DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(int.parse(detalle.fViaje))))), detalle.ruta, detalle.referencia,detalle.precio]);
                    });
                    sheetObject.appendRow(["", "", "TOTAL",element.total]);
                    // Save the Changes in file
                    excel.save(fileName: 'Reporte ${element.proveedor} - GAVIOTA ${StandarizeDate().getStringDate(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(initialDate)))}"-"${
                        StandarizeDate().getStringDate(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(endDate)))}.xlsx');
                  },
                  icon: Image(image: AssetImage("assets/excel_icon.png"), fit: BoxFit.contain,))
            ],
          )
      );
      widgetCobros.add(detalleCobroHeader);
      element.detallePasajero.forEach((detalle) {
        Widget detalleCobro = Dismissible(
          key: Key(detalle.referencia+detalle.ruta),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _containerDeuda(context, "${DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(int.parse(detalle.fViaje)))}", "hdeader", 200),
                _containerDeuda(context, detalle.ruta, "headedr", 200),
                _containerDeuda(context, detalle.referencia, "hdeader", 300),
                _containerDeuda(context, detalle.precio.toString(), "headder", 200),
              ]
          ),
          onDismissed: (direction)async{
            await LogicReport().updateReport(context, detalle.id);
          },
        );
        widgetCobros.add(detalleCobro);
      });
      widgetCobros.add(SizedBox(height: 30));
    });

    return (reportModel.ventas == 0)
        ? Container(child: Text("No se ha generado nigun reporte"), margin: EdgeInsets.only(top: size.height * 0.4),)
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgetCobros,
    );
  }
  Widget _container(BuildContext context, String text, String type){
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 200,
      color: (type == "header") ? Theme.of(context).primaryColor.withOpacity(0.5) :Theme.of(context).primaryColor.withOpacity(0.1),
      child: Text(text, style: TextStyle(fontWeight: (type =="header") ? FontWeight.bold:FontWeight.normal),),
    );
  }
  Widget _containerDeuda(BuildContext context, String text, String type, double width){
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: width,
      color: (type == "header") ? Colors.blueAccent.withOpacity(0.5) :Colors.blueAccent.withOpacity(0.1),
      child: Text(text, style: TextStyle(fontWeight: (type =="header") ? FontWeight.bold:FontWeight.normal),),
    );
  }
}
