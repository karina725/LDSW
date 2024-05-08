import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


Future <List> getCatalogo() async {
  List catalogo = [];

  CollectionReference collectionReferencecatalogo = db.collection("catalogo");
  QuerySnapshot queryCatalogo = await collectionReferencecatalogo.get();

  queryCatalogo.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final peli ={
      "titulo": data["titulo"],
      "uid":documento.id,
    };
    catalogo.add(peli);

   });

  return  catalogo;
}

Future<void> addCatalogo(String titulo) async{
  await db.collection("catalogo").add({
    "titulo": titulo});
}

Future<void> updateTitulo(String uid, String newTitulo )async{
  await db.collection("catalogo").doc(uid).set({"titulo":newTitulo}) ;
}

Future<void>deleteCatalogo(String uid) async{
  await db.collection("catalogo").doc(uid).delete();
}

