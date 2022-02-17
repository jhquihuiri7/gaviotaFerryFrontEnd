import 'package:flutter/material.dart';
class BoardingPassHeaderWidget extends StatelessWidget {
  const BoardingPassHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image:AssetImage("assets/DSD_logo.jpg"),
              height: 80,
            ),
            Text("0000111", style: TextStyle(fontSize: 19, color: Colors.red))
          ],
        ),
        SizedBox(width: 20),
        Column(
          children: [
            Container(

              alignment: Alignment.center,
              child: Text("BOARDING PASS", style: TextStyle(fontSize: 27, color: Color(0xff001a33), fontWeight: FontWeight.bold),),
              width: 300,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xff001a33), width: 3))),
            ),
            SizedBox(height: 15,),
            Text("TRANSPORTE MARITIMO INTERISALAS",style: TextStyle(fontSize: 20, color: Color(0xff001a33), fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text("Av. Española y Charles Darwin",style: TextStyle(fontSize: 17, color: Color(0xff001a33) ),),
            SizedBox(height: 5,),
            Text("Teléfonos: 0998927034 - 0994679756",style: TextStyle(fontSize: 17, color: Color(0xff001a33))),
            SizedBox(height: 5,),
            Text("Email: gaviota.ferry@gmail.com", style: TextStyle(fontSize: 17, color: Color(0xff001a33)),),
          ],
        ),
        SizedBox(width: 100),
      ],
    );
  }
}
