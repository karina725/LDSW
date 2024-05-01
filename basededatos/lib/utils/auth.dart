
import 'package:firebase_auth/firebase_auth.dart'; // Asegúrate de importar el archivo correcto para la página del dashboard

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> createAccount(String email, String password, formData) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential.user);
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("La contraseña es débil");
        return "weak-password";
      } else if (e.code == "email-already-in-use") {
        print("El Email ya está en uso");
        return "email-already-in-use";
      } else {
        print(e);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> signInEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        return user.uid;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "user-not-found";
      } else if (e.code == "wrong-password") {
        return "wrong-password";
      } else {
        print(e);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}