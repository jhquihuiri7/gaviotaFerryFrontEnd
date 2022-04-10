import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';

class DropDownWidget extends StatefulWidget {
  final String option;
  const DropDownWidget({required this.option});
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String dropdownValue = "";
  String dropdownValueStatus = "Transeunte";
  bool dropdownValueChange = false;
  @override
  Widget build(BuildContext context) {
    final ventasProvider = Provider.of<VentasProvider>(context);
    String _selectInitialValue(){
      if (widget.option == "ruta"){
        ventasProvider.reservasModel.ruta = "SC-SX";
        return "SC-SX";
      }else if (widget.option == "precio"){
        ventasProvider.reservasModel.precio = 25;
        return "25";
      }else {
        ventasProvider.reservasModel.status = "Permanente";
        return "Permanente";
      }
    }
    String _selectStatus (){
      if (ventasProvider.autocompleteUser.status != ""){
        dropdownValueStatus = ventasProvider.autocompleteUser.status;
      }
      setState(() {}
      );
      return dropdownValueStatus;
    }
    List<String> _selectValueOptions(){
      if (widget.option == "ruta"){
        return <String>["SC-SX", 'SX-SC'];
      }else if (widget.option == "precio"){
        return <String>["0", "15","20","25","30"];
      }else {
        return <String>["Permanente", "Temporal","Transeunte","Turista"];
      }
    }
    String value(){
      if (dropdownValueChange == false){
        dropdownValue = _selectInitialValue();
      }
      return dropdownValue;
    }
    return DropdownButton<String>(
      value: (widget.option == "status") ?  _selectStatus() :value(),
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: Style().dateStyle,
      underline: Container(
        height: 1,
        color: Colors.grey,
      ),
      onChanged: (String? newValue) {
        dropdownValueChange = true;
        setState(() {
          if (widget.option == "ruta"){
            dropdownValue = newValue!;
            ventasProvider.reservasModel.ruta = newValue;
          } else if (widget.option == "precio"){
            dropdownValue = newValue!;
            ventasProvider.reservasModel.precio = int.parse(newValue);
          }else {
            dropdownValueStatus = newValue!;
            ventasProvider.reservasModel.status = dropdownValueStatus;
          }
        });
      },
      items: _selectValueOptions()
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
