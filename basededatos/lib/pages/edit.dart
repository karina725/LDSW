import 'package:basededatos/servicios/servis.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  static const String routename = "Edit";

  final String titulo;
  final String uid;

  const Edit({Key? key, required this.titulo, required this.uid}) : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController tituloController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tituloController.text = widget.titulo; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar"),
      ),
      body: Column(
        children: [
          TextField(
            controller: tituloController,
            decoration: const InputDecoration(
              hintText: "Modificar el nombre",
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await updateTitulo(widget.uid, tituloController.text).then((value) {
                Navigator.pop(context);
              });
            },
            child: const Text("Modificar"),
          ),
        ],
      ),
    );
  }
}