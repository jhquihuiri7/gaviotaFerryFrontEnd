import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          width: size.width * 0.5,
          height: size.height,
          child: const Image(
            image: AssetImage("assets/DSD_logo.jpg"),
          ),
        ),
        Container(
          width: size.width * 0.5,
          height: size.height,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
