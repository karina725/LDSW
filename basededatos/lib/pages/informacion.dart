import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:basededatos/pages/administracion.dart';
import 'package:basededatos/pages/edit.dart';

class Informacion extends StatefulWidget {
  static const String routename = "Informacion";

  const Informacion({Key? key, required this.imageUrl});

  final String imageUrl;

  @override
  _InformacionState createState() => _InformacionState();
}

class _InformacionState extends State<Informacion> {
  late String titulo;
  late String fecha;
  late String director;
  late String genero;
  late String sinopsis;
  late String uid;
  late String imageUrl;

  Future<void> deleteCatalogo(String uid) async {
    await FirebaseFirestore.instance.collection("catalogo").doc(uid).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("catalogo").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay datos disponibles"));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmación"),
                        content: const Text("¿Estás seguro que deseas eliminar este elemento?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancelar"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await deleteCatalogo(document.id);
                              Navigator.of(context).pop(true);
                            },
                            child: const Text("Eliminar"),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (direction) {
                  
                  setState(() {
                    
                  });
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: SizedBox(
                      width: 90,
                      height: 120,
                      child: Image.network(
                        data["imageUrl"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      data["titulo"] ?? "",
                      style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Año: ${data["fecha"] ?? ""}",
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    onTap: () {
                      setState(() {
                        titulo = data["titulo"] ?? "";
                        fecha = data["fecha"] ?? "";
                        director = data["director"] ?? "";
                        genero = data["genero"] ?? "";
                        sinopsis = data["sinopsis"] ?? "";
                        uid = document.id;
                        imageUrl = data["imageUrl"];
                      });
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (imageUrl != null) Image.network(imageUrl),
                                  Text("Título: $titulo", style: const TextStyle(fontSize: 25.0)),
                                  Text("Fecha: $fecha", style: const TextStyle(fontSize: 20.0)),
                                  Text("Director: $director", style: const TextStyle(fontSize: 20.0)),
                                  Text("Género: $genero", style: const TextStyle(fontSize: 20.0)),
                                  Text("Sinopsis: $sinopsis", style: const TextStyle(fontSize: 20.0)),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Edit(
                                            titulo: titulo,
                                            subtitle: fecha,
                                            uid: uid,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Editar"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Administrador ()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}