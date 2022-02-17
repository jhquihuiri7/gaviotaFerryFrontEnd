import 'package:darwin_scuba_dive/src/widgets/boarding_pass/boarding_pass_body_widget.dart';
import 'package:darwin_scuba_dive/src/widgets/boarding_pass/boarding_pass_footer_widget.dart';
import 'package:darwin_scuba_dive/src/widgets/boarding_pass/boarding_pass_header_widget.dart';
import 'package:flutter/material.dart';
class BoardingPassWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              BoardingPassHeaderWidget(),
              SizedBox(height: 20,),
              BoardingPassBodyWidget(),
              SizedBox(height: 20,),
              BoardingPassFooterWidget(),
            ],
          ),
        )
      );
  }
}
