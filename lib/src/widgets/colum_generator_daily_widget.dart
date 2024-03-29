import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'colum_generator_daily_widget.dart';
import 'package:http/http.dart' as http;
export 'package:intl/intl.dart';

class ColumnGeneratorDailyWidget extends StatefulWidget {
  const ColumnGeneratorDailyWidget({Key? key}) : super(key: key);

  @override
  State<ColumnGeneratorDailyWidget> createState() => _ColumnGeneratorDailyWidgetState();
}

class _ColumnGeneratorDailyWidgetState extends State<ColumnGeneratorDailyWidget> {
  @override
  String time = "Todo";
  String timeBefore = "Todo";

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ventasProvider = Provider.of<VentasProvider>(context);
    
    return FutureBuilder(
        future: LogicDaily().getDailyData(context, time),
        builder: (BuildContext c,AsyncSnapshot<List<ReservasModel>> s){
            List<Widget> rows = [];
            int id = 1;
            if (s.hasData){
              final List<ReservasModel>? data = s.data;
              data?.forEach((element) {
                final widgetTemp = Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Theme.of(context).primaryColor,),
                  onDismissed: (direction) async {
                  await http.post(Uri.parse("https://gaviota-ferry-backend.uc.r.appspot.com/deleteUser/${element.id}"));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.1)))
                    ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CellWidget(cellWidth: 0.03, value: (element.edad < 3) ? "" : "${id++}", type: "raw",),
                      CellWidget(cellWidth: 0.1, value: DateFormat('dd-MM-yyyy').format(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(int.parse(element.fReserva)))), type: "raw",),
                      CellWidget(cellWidth: 0.2, value: element.referencia, type: "raw",),
                      CellWidget(cellWidth: 0.15, value: element.proveedor, type: "raw",),
                      CellWidget(cellWidth: 0.1, value: element.cedula, type: "raw",),
                      CellWidget(cellWidth: 0.1, value: "\$${element.precio}", type: "raw",),
                      CellWidget(cellWidth: 0.2, value: element.observacion, type: "raw",),
                      Container(width: size.width * 0.1,
                        child:Row(
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                EditWidget().showAlert(context, element);
                              },
                              child: Text("Editar")
                            ),
                            Switch(
                              value: element.pagado,
                              onChanged: (value) async {
                                print(value);
                                element.pagado = value;
                                await LogicDaily().updateData(element);
                                setState(() {});
                              }
                            )
                          ],
                        ),
                      )
                    ]
                    ),
                  )
                );
                rows.add(widgetTemp);
              });
              rows.add(SizedBox(height: 90));
              return Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      const Text("Resumen de Diarios", style: TextStyle(fontSize: 30),),
                      SizedBox(width: 40),
                      ElevatedButton(
                          style: Style().datesStyle,
                          onPressed: (){
                            DatePickerFunction().datePicker(context, "daily");
                          },
                          child: Text(DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(int.parse(ventasProvider.dateDaily)))), style: Style().dateStyle,)
                      ),
                      SizedBox(width: 40),
                      DropdownButton(
                          value: time,
                          items: ["Todo","AM","PM"].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value){
                            time = value.toString();
                            setState(() {});
                          })
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CellWidget(cellWidth: 0.03, value: "Id", type: "col",),
                        CellWidget(cellWidth: 0.1, value: "Fecha Reserva", type: "col",),
                        CellWidget(cellWidth: 0.2, value: "Referencia", type: "col",),
                        CellWidget(cellWidth: 0.15, value: "Proveedor", type: "col",),
                        CellWidget(cellWidth: 0.1, value: "Cédula", type: "col",),
                        CellWidget(cellWidth: 0.1, value: "Precio", type: "col",),
                        CellWidget(cellWidth: 0.2, value: "Observacion", type: "col",),
                        CellWidget(cellWidth: 0.1, value: "Acciones", type: "col",),
                      ],
                    ),
                  ),
                  Expanded(
                      child: (s.data!.length == 0) ? Center(child: Text("No hay datos"),) :SingleChildScrollView(
                        child: Column(
                          children: rows,
                        ),
                      )
                  )
                ],
              );
            }else {
              return Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 40),
                      const Text("Resumen de Diarios", style: TextStyle(fontSize: 30),),
                      SizedBox(width: 40),
                      ElevatedButton(
                          style: Style().datesStyle,
                          onPressed: (){
                            DatePickerFunction().datePicker(context, "daily");
                          },
                          child: Text(DateFormat("dd/MM/yyyy").format(DateTime.fromMicrosecondsSinceEpoch(StandarizeDate().standarizeDate(int.parse(ventasProvider.dateDaily)))), style: Style().dateStyle,)
                      ),
                      SizedBox(width: 40),
                      DropdownButton(
                          value: time,
                          items: ["Todo","AM","PM"].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value){
                            time = value.toString();
                            setState(() {});
                          })
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CellWidget(cellWidth: 0.03, value: "Id", type: "col",),
                        CellWidget(cellWidth: 0.1, value: "Fecha Reserva", type: "col",),
                        CellWidget(cellWidth: 0.2, value: "Referencia", type: "col",),
                        CellWidget(cellWidth: 0.15, value: "Proveedor", type: "col",),
                        CellWidget(cellWidth: 0.1, value: "Cédula", type: "col",),
                        CellWidget(cellWidth: 0.1, value: "Precio", type: "col",),
                        CellWidget(cellWidth: 0.2, value: "Observacion", type: "col",),
                        CellWidget(cellWidth: 0.1, value: "Acciones", type: "col",),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Center(child:CircularProgressIndicator())
                  )
                ],
              );
            }
        }
    );
  }
}
