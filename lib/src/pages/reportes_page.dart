import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:darwin_scuba_dive/src/widgets/reportes/settings_widget.dart';
import 'package:flutter/material.dart';
class ReportesPage extends StatelessWidget {
  const ReportesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(child: SingleChildScrollView(child: SettingsWidget(),))
        ],
      ),
    );
  }
}
