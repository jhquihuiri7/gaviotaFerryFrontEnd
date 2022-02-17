import 'package:darwin_scuba_dive/src/widgets/colum_generator_daily_widget.dart';
import 'package:flutter/material.dart';
class DailyGridWidget extends StatefulWidget {
  const DailyGridWidget({Key? key}) : super(key: key);

  @override
  State<DailyGridWidget> createState() => _DailyGridWidgetState();
}

class _DailyGridWidgetState extends State<DailyGridWidget> {
  int id = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SingleChildScrollView(
          child: ColumnGeneratorDailyWidget(),
        ),
      ],
    );
  }
}
