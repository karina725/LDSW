import 'package:basededatos/servicios/servis.dart';
import 'package:flutter/material.dart';

class Administrador extends StatefulWidget {
  static const String routename = "Creacion";

  const Administrador({Key? key});

  @override
  _AdministradorState createState() => _AdministradorState();
}

class _AdministradorState extends State<Administrador> {
  TextEditingController tituloController = TextEditingController(text: "");
  TextEditingController fechaController = TextEditingController(text: "");
  TextEditingController directorController = TextEditingController(text: "");
  TextEditingController generoController = TextEditingController(text: "");
  TextEditingController sinopsisController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                hintText: "Título",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: fechaController,
              decoration: const InputDecoration(
                hintText: "Año",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: directorController,
              decoration: const InputDecoration(
                hintText: "Director",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: generoController,
              decoration: const InputDecoration(
                hintText: "Género",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: sinopsisController,
              decoration: const InputDecoration(
                hintText: "Sinopsis",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await addCatalogo(
                  tituloController.text,
                  fechaController.text,
                  directorController.text,
                  generoController.text,
                  sinopsisController.text,
                );
                Navigator.pop(context);
              },
              child: const Text("Agregar"),
            ),
          ],
        ),
      ),
    );
  }
}