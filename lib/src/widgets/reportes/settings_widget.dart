import 'package:darwin_scuba_dive/src/model/reporte_model.dart';
import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:darwin_scuba_dive/src/utils/logic_report.dart';
import 'package:darwin_scuba_dive/src/utils/logic_ventas.dart';
import 'package:darwin_scuba_dive/src/utils/range_picker.dart';
import 'package:darwin_scuba_dive/src/widgets/reportes/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class SettingsWidget extends StatefulWidget {

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  int initialDate = LogicVentas().getDateTimeNow();

  int endDate = LogicVentas().getDateTimeNow();

  ReporteModel report = ReporteModel(ventas: 0, facturado: 0, recuperado: 0, recuperar: 0, detalle: []);

  bool loadingReport = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40),
            const Text("Reportes Ventas", style: TextStyle(fontSize: 30),),
            SizedBox(width: 40),
            ElevatedButton(
                style: Style().datesStyle,
                onPressed: ()async {
                  List<int> rangePicker = await RangePickerFunction().rangePicker(context);
                  initialDate = rangePicker[0];
                  endDate = rangePicker[1];
                  setState(() {
                  });
                },
                child: Text("${DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(initialDate))} - ${DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(endDate))}", style: Style().dateStyle,)
            ),
            SizedBox(width: 40),
            ElevatedButton(
                style: Style().datesStyle,
                onPressed: ()async {
                  loadingReport = true;
                  setState(() {});
                  report = await LogicReport().getReport(context, initialDate, endDate);
                  loadingReport = false;
                  setState(() {});

                },
                child: Text("Generar Reporte", style: Style().dateStyle,)
            )
          ],
        ),
        (loadingReport)
            ? Container(child: CircularProgressIndicator(),margin: EdgeInsets.only(top: size.height * 0.4),)
            : SingleChildScrollView(child: ReportWidget(reportModel: report),),
      ],
    );
  }
}
