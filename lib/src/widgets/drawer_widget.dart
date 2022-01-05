import 'package:darwin_scuba_dive/src/utils/export_widgets.dart';
import 'package:flutter/material.dart';


class DrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Image(
                        image: AssetImage("assets/DSD_logo.jpg"),
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Text("Darwin Scuba Dive", style: Style().style)
                  ],
                )
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ventas"),
              onTap: (){
                Navigator.pushReplacementNamed(context, 'ventas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Diarios"),
              onTap: (){
                Navigator.pushReplacementNamed(context, 'diarios');
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text("Reportería"),
              onTap: (){
                Navigator.pushReplacementNamed(context, 'reportes');
              },
            ),
            const Expanded(child: SizedBox()),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Cerrar Sesión"),
              onTap: (){},
            ),
          ],
        )
    );
  }
}
