import 'package:universal_html/html.dart' as html;
import 'package:pdf/widgets.dart';

class PdfApi {
  static saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    //html.window.open(url, "_blank");
    //html.Url.revokeObjectUrl(url);

    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = "$name.pdf";
    html.document.body?.children.add(anchor);

    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}