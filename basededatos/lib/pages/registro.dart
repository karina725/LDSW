import 'package:basededatos/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:basededatos/utils/auth.dart';
import 'package:basededatos/util/snackbar.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterPage extends StatelessWidget {
  static const String routename = "Register";

  final AuthService _auth = AuthService();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var formBuilderTextField = FormBuilderTextField(
      name: 'Correo electrónico',
      decoration: const InputDecoration(
        labelText: 'Correo electrónico',
      ),
      validator: FormBuilderValidators.email(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
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
                  image: AssetImage("assets/imagen3.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  formBuilderTextField,
                  const SizedBox(height: 20),
                  FormBuilderTextField(
                    name: 'Contraseña',
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        final formData = _formKey.currentState?.value;
                        if (formData != null) {
                          var result = await _auth.createAccount(
                              formData["Correo electrónico"] as String,
                              formData["Contraseña"] as String,
                              ""
                          );
                          if (result == "weak-password") {
                            showSnackBar(context, "Error de contraseña");
                          } else if (result == "email-already-in-use") {
                            showSnackBar(context, "Error, Email ya registrado");
                          } else if (result != null) {
                            Navigator.popAndPushNamed(context, LoginPage.routename);
                          }
                        }
                      }
                    },
                    child: const Text('Registrarse'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Volver al inicio de sesión',
                      style: TextStyle(
                        color: Color.fromARGB(255, 1, 47, 253),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}