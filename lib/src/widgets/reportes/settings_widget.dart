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
  final _formKey = GlobalKey<FormState>();
  String proveedor = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Row(
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
                  child: Text("${DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(initialDate)))} - ${DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(endDate)))}", style: Style().dateStyle,)
              ),
              SizedBox(width: 40),
              Container(
                child: TextFormField(
                  onSaved: (value){
                    if (value == null || value == ""){
                      proveedor = "NA";
                    }else {
                      proveedor = value;
                    }
                  },
                ), 
                width: 200,
              ),
              SizedBox(width: 40),
              ElevatedButton(
                  style: Style().datesStyle,
                  onPressed: ()async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();  
                    }
                    loadingReport = true;
                    setState(() {});
                    report = await LogicReport().getReport(context, StandarizeDate().standarizeDate(initialDate), StandarizeDate().standarizeDate(endDate), proveedor);
                    loadingReport = false;
                    setState(() {});
                  },
                  child: Text("Generar Reporte", style: Style().dateStyle,)
              )
            ],
          ) 
        ),
        (loadingReport)
            ? Container(child: CircularProgressIndicator(),margin: EdgeInsets.only(top: size.height * 0.4),)
            : SingleChildScrollView(child: ReportWidget(reportModel: report, initialDate: initialDate, endDate: endDate),),
      ],
    );
  }
}
