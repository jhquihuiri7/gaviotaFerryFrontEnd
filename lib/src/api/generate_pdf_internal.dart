import 'package:darwin_scuba_dive/src/api/pdf_api.dart';
import 'package:darwin_scuba_dive/src/api/pdf_parts.dart';
import 'package:darwin_scuba_dive/src/model/reservas_model.dart';
import 'package:darwin_scuba_dive/src/utils/logic_daily.dart';
import 'package:darwin_scuba_dive/src/utils/standarize_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApiInternal {
  late final pw.ImageProvider logo;

    generate(String date, BuildContext ctx) async {
      final List<ReservasModel> itemsAM = await LogicDaily().getDailyData(ctx, "AM");
      final List<ReservasModel> itemsPM = await LogicDaily().getDailyData(ctx, "PM");
      final dateEpoch = int.tryParse(date);
      final pdf = pw.Document();
      var data = await rootBundle.load("assets/OpenSans-Light.ttf");
      logo = pw.MemoryImage((await rootBundle.load('assets/DSD_logo.jpg')).buffer.asUint8List());

      final ttf = pw.Font.ttf(data);
      pdf.addPage(
        pw.MultiPage(
            header: _buildHeader,
            build: (context){
        return [
          pw.Column(
            children: [
              pw.SizedBox(height: 20),
              PDFParts().buildTable(context, "AM", StandarizeDate().getStringDate(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(dateEpoch!))), itemsAM, "Report","FERRY GAVIOTA","FORMATO DE CONTROL DE VENTAS INTERNO","REPORTE DE CARTERA DIARIA"),
              PDFParts().buildFooterReport(context, itemsAM),
              pw.SizedBox(height: 20),
              PDFParts().buildTable(context, "PM", StandarizeDate().getStringDate(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(dateEpoch))), itemsPM, "Report","FERRY GAVIOTA","FORMATO DE CONTROL DE VENTAS INTERNO","REPORTE DE CARTERA DIARIA"),
              PDFParts().buildFooterReport(context, itemsPM),
            ]
         )
        ];
      }));
    return PdfApi.saveDocument(name: "Reporte Interno ${StandarizeDate().getStringDate(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(dateEpoch!)))}", pdf: pdf);
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