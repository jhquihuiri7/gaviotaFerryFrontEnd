import 'package:darwin_scuba_dive/src/model/reservas_model.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFParts {
  pw.Widget buildTable (pw.Context context, String type, String date, List<ReservasModel> items){
    const _borderStyle = pw.BorderSide(width: 0.5);
    int _id = 1;
    final List<List<String>> data = (items.isEmpty) ? [] : items.map((item) => [
      (item.edad > 2) ? "${_id++}" : "",
      item.referencia,
      item.nacionalidad,
      item.cedula,
      item.edad.toString(),
      item.status,
      item.observacion,
    ]).toList();
    for (var i  = _id; i <= 38; i++){
      data.add(["$i","","","","","",""]);
    }
    return pw.Column(
        children: [
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["COE PROVINCIAL DE GALAPAGOS"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 13),
            cellPadding: pw.EdgeInsets.symmetric(vertical: 1),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["FORMATO DE CONTROL DE PASAJEROS AEREO Y MARITIMO"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
            cellPadding: pw.EdgeInsets.symmetric(vertical: 1),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["NOMBRE DEL TRANSPORTE: LANCHA GAVIOTA"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 6),
            cellPadding: pw.EdgeInsets.symmetric(vertical: 1),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["RUTA: SAN CRISTOBAL - SANTA CRUZ","FECHA: $date","HORA DE SALIDA: ${((type == "AM") ? "07:00" : "15:00")}"],
            headerStyle: const pw.TextStyle(fontSize: 6),
            cellPadding: pw.EdgeInsets.symmetric(vertical: 1),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,verticalInside: _borderStyle),
            headers: ["N°","NOMBRES Y APELLIDOS","PAIS","CEDULA","EDAD","STATUS RESIDENCIA","OBSERVACION"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8 ),
            data: data,
            cellStyle: const pw.TextStyle(fontSize: 8),
            cellPadding: const pw.EdgeInsets.symmetric(vertical: 1.5),
            rowDecoration: pw.BoxDecoration(border: pw.Border.all(width: 0.1)),
            headerDecoration: pw.BoxDecoration(border: pw.Border.all(width: 0.1)),
            cellAlignment: pw.Alignment.center,
            columnWidths: const {
              0: pw.FractionColumnWidth(0.025),
              1: pw.FractionColumnWidth(0.22),
              2: pw.FractionColumnWidth(0.1),
              3: pw.FractionColumnWidth(0.1),
              4: pw.FractionColumnWidth(0.075),
              5: pw.FractionColumnWidth(0.1),
              6: pw.FractionColumnWidth(0.23),
            }
          ),
        ]
    );
  }
  pw.Widget buildFooter (pw.Context context){
    const _borderStyle = pw.BorderSide(width: 0.5);
    return pw.Column(
        children: [
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["CAP. PABLO VERA S."],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            cellPadding: pw.EdgeInsets.only(top: 30, bottom: 0, right: 0, left: 0),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["LANCHA GAVIOTA"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            cellPadding: pw.EdgeInsets.symmetric(vertical: 1),
            data: [[],[]],
          ),
        ]
    );
  }


}