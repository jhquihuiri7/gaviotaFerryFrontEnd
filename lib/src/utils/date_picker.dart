import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';
import 'package:darwin_scuba_dive/src/utils/logic_ventas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePickerFunction {
  datePicker (BuildContext context, String type) async{
     final dateProvider = Provider.of<VentasProvider>(context, listen: false);
     final DateTime? picked = await showDatePicker(
         context: context,
         initialDate: DateTime.now(),
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
     if (type == "venta"){
       if (picked != null && picked != dateProvider.dateVenta) {
         dateProvider.dateVenta = picked;
         dateProvider.reservasModel.fViaje = picked.microsecondsSinceEpoch.toString();
       }
     }else if (type == "daily"){
       if (picked != null) {
         dateProvider.dateDaily = picked.microsecondsSinceEpoch.toString();
       }
     }
  }
}