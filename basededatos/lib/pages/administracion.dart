import 'dart:io';
import 'package:flutter/material.dart';
import 'package:basededatos/servicios/servis.dart';

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

  File? imagen_to_upload;

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
                hintStyle: TextStyle(
                  fontSize: 20.0,
                ),
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
                if (imagen_to_upload == null) {
                  
                  return;
                }

                final imageUrl = await uploadImage(imagen_to_upload!);

                
                if (imageUrl.isNotEmpty) {
                  await addCatalogo(
                    tituloController.text,
                    fechaController.text,
                    directorController.text,
                    generoController.text,
                    sinopsisController.text,
                    imageUrl, 
                  );

                 
                  tituloController.clear();
                  fechaController.clear();
                  directorController.clear();
                  generoController.clear();
                  sinopsisController.clear();

                  
                  setState(() {
                    imagen_to_upload = null;
                  });

                  Navigator.pop(context);
                } else {
                  
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Error"),
                        content: const Text("Hubo un problema al cargar la imagen."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Aceptar"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text("Agregar"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
            child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.blue,
                child: Center(
                  child: imagen_to_upload != null
                      ? Image.file(
                          imagen_to_upload!,
                          fit: BoxFit.cover,
                        )
                      : const Text("No hay imagen seleccionada"),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final imagen = await getImage();

                setState(() {
                  imagen_to_upload = File(imagen!.path);
                });
              },
              child: const Text("Seleccionar imagen"),
            ),
          ],
        ),
      ),
    );
  }
}


          