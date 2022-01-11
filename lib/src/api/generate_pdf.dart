import 'dart:html';
import 'dart:typed_data';
import 'package:darwin_scuba_dive/src/api/pdf_api.dart';
import 'package:darwin_scuba_dive/src/api/pdf_parts.dart';
import 'package:darwin_scuba_dive/src/model/reservas_model.dart';
import 'package:darwin_scuba_dive/src/utils/logic_daily.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';


import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';


class PdfInvoiceApi {
  late final pw.ImageProvider logo;

    String getStringDate(DateTime date){
      int day =  date.day;
      int month = date.month;
      int year = date.year;
      switch (month) {
        case 1:
          return '$day ENERO $year';
        case 2:
          return '$day FEBRERO $year';
        case 3:
          return '$day MARZO $year';
        case 4:
          return '$day ABRIL $year';
        case 5:
          return '$day MAYO $year';
        case 6:
          return '$day JUNIO $year';
        case 7:
          return '$day JULIO $year';
        case 8:
          return '$day AGOSTO $year';
        case 9:
          return '$day SEPTIEMBRE $year';
        case 10:
          return '$day OCTUBRE $year';
        case 11:
          return '$day NOVIEMBRE $year';
        case 12:
          return '$day DICIEMBRE $year';
        default:
          return '$day Enero $year';
      }
    }
    generate(String type, String date, BuildContext ctx) async {
      final List<ReservasModel> items = await LogicDaily().getDailyData(ctx, type);
      final dateEpoch = int.tryParse(date);
      final pdf = pw.Document();
      var data = await rootBundle.load("assets/OpenSans-Light.ttf");
      logo = pw.MemoryImage((await rootBundle.load('assets/header-icon.png')).buffer.asUint8List());

      final ttf = pw.Font.ttf(data);
      pdf.addPage(
        pw.MultiPage(
            header: _buildHeader,
            build: (context){
        return [
          pw.Column(
            children: [
              pw.SizedBox(height: 20),
              PDFParts().buildTable(context, type, getStringDate(DateTime.fromMicrosecondsSinceEpoch(dateEpoch!)), items),
              PDFParts().buildFooter(context),
            ]
         )
        ];
      }));
    return PdfApi.saveDocument(name: "${getStringDate(DateTime.fromMicrosecondsSinceEpoch(dateEpoch!))} $type", pdf: pdf);
  }
  pw.Widget _buildHeader(pw.Context context){

    return pw.Row(
      children: [
        pw.Container(
          height: 40,
          width:50,
          child: logo != null ? pw.Image(logo) : pw.PdfLogo(),
        )
      ]
    );
  }
  
}