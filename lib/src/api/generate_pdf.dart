import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  late final pw.ImageProvider logo;

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
              PDFParts().buildTable(context, type, StandarizeDate().getStringDate(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(dateEpoch!))), items, "COE", "COE PROVINCIAL DE GALAPAGOS","FORMATO DE CONTROL DE PASAJEROS AEREO Y MARITIMO","NOMBRE DEL TRANSPORTE: LANCHA GAVIOTA"),
              PDFParts().buildFooter(context),
            ]
         )
        ];
      }));
    return PdfApi.saveDocument(name: "${StandarizeDate().getStringDate(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(dateEpoch!)))} $type", pdf: pdf);
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