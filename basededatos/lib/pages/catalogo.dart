import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:basededatos/pages/administracion.dart';
import 'package:basededatos/pages/informacion.dart'; 
import 'package:basededatos/servicios/servis.dart';

class Catalogo extends StatefulWidget {
  static const String routename = "Catalogo";
  
  const Catalogo({Key? key});
  
  @override
  State<Catalogo> createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catalogo"),
      ),
      body: FutureBuilder(
        future: getCatalogo(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async{
                    await deleteCatalogo(snapshot.data?[index]["uid"]);
                  },
                  confirmDismiss: (direction) async{
                    bool result = false;

                    result = await showDialog(context: context, builder: (context){
                      return  AlertDialog(
                        title: Text(
                          "¿Está seguro de eliminarlo la Pelicula ${snapshot.data?[index]["titulo"]}?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              return Navigator.pop(
                                context,
                                false,
                              );
                            }, 
                            child: const Text(
                              "Cancelar",
                              style:TextStyle(color: Colors.red),
                            )
                          ),
                          TextButton(
                            onPressed: () {
                              return Navigator.pop(
                                context,
                                true,
                              );
                            }, 
                            child: const Text("Si, estoy seguro")
                          )
                        ],
                      );
                    });
                    return result;
                  } ,
                  background:  Container (
                    color: Colors.red,
                    child: const Icon(Icons.delete) 
                  ),
                  direction: DismissDirection.endToStart,
                  key: ValueKey<String>(snapshot.data?[index]["uid"]),
                  child: ListTile(
                    title: Text(snapshot.data?[index]["titulo"]),
                    subtitle: Text("Año: ${snapshot.data?[index]["fecha"]}"),
                    leading: SizedBox(
                      width: 90,
                      height: 120,
                      child: FutureBuilder(
                        future: firebase_storage.FirebaseStorage.instance.ref().getDownloadURL(),
                        builder: (BuildContext context, AsyncSnapshot<String> urlSnapshot) {
                          if (urlSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (urlSnapshot.hasError) {
                            return Text('Error: ${urlSnapshot.error}');
                          }
                          return Image.network(
                            urlSnapshot.data!,
                            fit: BoxFit.cover, 
                          );
                        },
                      ),
                    ),
                    onTap: () async {
                      final titulo = snapshot.data?[index]["titulo"];
                      final uid = snapshot.data?[index]["uid"];
                      final imageUrl = snapshot.data?[index]["imageUrl"]; 
                      if(titulo != null && uid != null && imageUrl != null){ 
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Informacion(imageUrl: imageUrl),
                          ),
                        );
                      }                   
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () {
          Navigator.push (
            context, 
            MaterialPageRoute(builder: (context) => const Administrador ()),
          );
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}