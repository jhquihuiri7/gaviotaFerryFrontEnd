import 'package:darwin_scuba_dive/src/provider/ventas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DatePickerFunction {
  datePicker (BuildContext context, String type) async{
     final dateProvider = Provider.of<VentasProvider>(context, listen: false);
     DateTime dateTimeNow = DateTime.parse("${DateTime.now().year}${(DateTime.now().month< 10)?0:""}${DateTime.now().month}${(DateTime.now().day< 10)?0:""}${DateTime.now().day}");
     final DateTime? picked = await showDatePicker(
         context: context,
         initialDate: DateTime.parse("${DateTime.now().year}${(DateTime.now().month< 10)?0:""}${DateTime.now().month}${(DateTime.now().day< 10)?0:""}${DateTime.now().day}"),
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
         if (dateTimeNow.microsecondsSinceEpoch % 86400000000 / 86400000000 == 0.25){
           dateProvider.reservasModel.fViaje = (picked.microsecondsSinceEpoch - 3600000000).toString();
         }else {
           dateProvider.reservasModel.fViaje = picked.microsecondsSinceEpoch.toString();
         }
       }
     }else if (type == "daily"){
       if (picked != null) {
         if (dateTimeNow.microsecondsSinceEpoch % 86400000000 / 86400000000 == 0.25){
           dateProvider.dateDaily = (picked.microsecondsSinceEpoch - 3600000000).toString();
         }else {
           dateProvider.dateDaily = picked.microsecondsSinceEpoch.toString();
         }
       }
     }else if (type == "updateDaily"){
       if (picked != null) {
         if (dateTimeNow.microsecondsSinceEpoch % 86400000000 / 86400000000 == 0.25){
           dateProvider.updateDateDaily = (picked.microsecondsSinceEpoch - 3600000000).toString();
         }else {
           dateProvider.updateDateDaily = picked.microsecondsSinceEpoch.toString();
         }
       }
     }
  }
}