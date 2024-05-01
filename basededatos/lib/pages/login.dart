import 'package:basededatos/pages/registro.dart';
import 'package:flutter/material.dart';
import 'package:basededatos/util/snackbar.dart';

class LoginPage extends StatelessWidget {
  static const String routename = "Login";

   const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pelifans"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/imagen2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showSnackBar(context, "Estamos mostrando un mensaje");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Iniciar sesión',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push (
                      context, 
                      MaterialPageRoute(builder: (context) =>  RegisterPage()),
                      );
                  },
                  child: const Text("Registrarse", 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0),
                      )
                ),
              ], 
            ), 
          ], 
        ), 
      ), 
    ); 
  } 
}