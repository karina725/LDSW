import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

final FirebaseStorage storage = FirebaseStorage.instance; 


Future <List> getCatalogo() async {
  List catalogo = [];

  CollectionReference collectionReferencecatalogo = db.collection("catalogo");
  QuerySnapshot queryCatalogo = await collectionReferencecatalogo.get();

  queryCatalogo.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final peli ={
      "titulo": data["titulo"],
      "fecha": data["fecha"],
      "imageUrl":data["imageUrl"],
      "uid":documento.id,
    };
    catalogo.add(peli);

   });

  return  catalogo;
}


Future<void> addCatalogo(String titulo, String fecha, String director, String genero, String sinopsis, imageUrl,   )  async {
   db.collection("catalogo").add({
    "titulo": titulo,
    "fecha": fecha,
    "director": director,
    "genero": genero,
    "sinopsis": sinopsis,
    "imageUrl": imageUrl,
  });
}



Future<void> updateTitulo(String uid, String newTitulo )async{
  await db.collection("catalogo").doc(uid).set({"titulo":newTitulo}) ;
}

Future<void>deleteCatalogo(String uid) async{
  await db.collection("catalogo").doc(uid).delete();
}


Future getImage () async{
  final ImagePicker picker = ImagePicker();

  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  return image;
}


Future<String> uploadImage(File image) async {
  final String nameFile = image.path.split("/").last;
  final Reference ref = storage.ref().child("images/").child(nameFile);
  final UploadTask uploadTask = ref.putFile(image);

  try {
    
    await uploadTask;
    
    final String url = await ref.getDownloadURL();
    return url; 
  } catch (e) {
    
    print("Error al cargar la imagen: $e");
    return ""; 
  }
}

