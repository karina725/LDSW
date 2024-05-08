import 'package:basededatos/servicios/servis.dart';
import 'package:flutter/material.dart';

class Administrador extends StatefulWidget {
  static const String routename = "Creacion";

  const Administrador({super.key});

  @override
  _AdministradorState createState() => _AdministradorState();
}

class _AdministradorState extends State<Administrador> {
TextEditingController tituloController = TextEditingController(text:" ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador"),
      ),
      body:  Column(
        children: [
          TextField(
            controller: tituloController,
            decoration: const InputDecoration(
              hintText: "Insertar Nueva Titulo",
            ),
          ),
          ElevatedButton(
            onPressed:() async {
              addCatalogo(tituloController.text);
              Navigator.pop(context);
            },
             child: const Text("Agregar"))
        ],
      ),
    );
  }
}