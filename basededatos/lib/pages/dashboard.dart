

import "package:basededatos/pages/informacion.dart";
import "package:flutter/material.dart";

class DashboardPage extends StatelessWidget {
  static const String routename = "Dashboard";

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pelifans"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:  Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/imagen4.jpg"),
                  fit: BoxFit.cover,
                  ),
              ),
            ),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "¡Bienvenido al Catalogo!",
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Color.fromARGB(255, 245, 0, 0),
                  ),
                  ),
                   const SizedBox(height: 20),
                  ElevatedButton(
                  onPressed: () {Navigator.push (
                      context, 
                      MaterialPageRoute(builder: (context) =>   const Informacion (imageUrl: '',)),
                      );
                  },
                    child:  const Text ("Catalogo",
                    style: TextStyle(
                      fontSize: 30.0,
                    ),),
                     )
              ],
            )
          ],
        ),
      ),
    );
  }
}