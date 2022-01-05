import 'package:universal_html/html.dart' as html;

import 'package:pdf/widgets.dart';

class PdfApi {
  static saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    print("DIRECTORIO");

    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    print(url);
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
    print('Hola');

  }
}