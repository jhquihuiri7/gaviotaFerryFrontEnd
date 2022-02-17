import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';
import 'package:darwin_scuba_dive/src/utils/logic_ventas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RangePickerFunction {
  Future<List<int>> rangePicker (BuildContext context) async{
     final dateProvider = Provider.of<VentasProvider>(context, listen: false);
     final picked = await showDateRangePicker(
         context: context,
         firstDate: DateTime(2021),
         lastDate: DateTime(2023),
         builder: (BuildContext context, Widget? child){
           return Theme(
             data: ThemeData.light().copyWith(
               colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor,),
               buttonTheme: const ButtonThemeData(
                   textTheme: ButtonTextTheme.primary
               ),
             ),
             child: child!,
           );
         }
     );
     if (picked != null) {
       return [picked.start.microsecondsSinceEpoch, picked.end.microsecondsSinceEpoch];
     }else{
       return [LogicVentas().getDateTimeNow(), LogicVentas().getDateTimeNow()];
     }

  }
}