import 'package:darwin_scuba_dive/src/model/reservas_model.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFParts {
  pw.Widget buildTable (pw.Context context, String type, String date, List<ReservasModel> items){
    const _borderStyle = pw.BorderSide(width: 0.5);
    int _id = 1;
    final List<List<String>> data = items.map((item) => [
      (item.edad > 2) ? "${_id++}" : "",
      item.referencia,
      item.nacionalidad,
      item.cedula,
      item.edad.toString(),
      item.status,
      item.observacion,
    ]).toList();
    return pw.Column(
        children: [
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["COE PROVINCIAL DE GALAPAGOS"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["FORMATO DE CONTROL DE PASAJEROS AEREO Y MARITIMO"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["NOMBRE DEL TRANSPORTE: LANCHA GAVIOTA"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["RUTA: SAN CRISTOBAL - SANTA CRUZ","FECHA: $date","HORA DE SALIDA: ${((type == "AM") ? "07:00" : "15:00")}"],
            headerStyle: const pw.TextStyle(fontSize: 8),
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["N°","NOMBRES Y APELLIDOS","PAIS","CEDULA","EDAD","STATUS RESIDENCIA","OBSERVACION"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10 ),
            data: data,
            cellStyle: pw.TextStyle(fontSize: 10),
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
            data: [[],[]],
          ),
          pw.Table.fromTextArray(
            border: const pw.TableBorder(left: _borderStyle, right:_borderStyle ,top: _borderStyle,bottom:_borderStyle,),
            headers: ["LANCHA GAVIOTA"],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            data: [[],[]],
          ),
        ]
    );
  }


}