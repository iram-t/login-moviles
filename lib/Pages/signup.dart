import 'package:flutter/material.dart';
import 'package:login/providers/login_provider.dart';
import 'package:login/services/auth.dart';
import 'package:login/services/notification_services.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200),
            const Text(
              'Registro',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            ChangeNotifierProvider(
                create: (_) => LoginFormProvider(), child: _SignUpForm())
          ],
        ),
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginFrom = Provider.of<LoginFormProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: loginFrom.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(labelText: 'Correo Electronico'),
              onChanged: (value) => loginFrom.email = value,
              // se esta usando una expresion regular para comparar la cadena con el patron
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            const SizedBox(height: 4),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              onChanged: (value) => loginFrom.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : "La contraseña debe de tener mas de 6 caracteres";
              },
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: loginFrom.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!loginFrom.isValidForm()) return;
                      loginFrom.isLoading = true;

                      //Validar si el login es correcto
                      final String? errorMessage = await authService.createUser(
                          loginFrom.email, loginFrom.password);
                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        // Mostrar el error en pantalla
                        NotificationServices.showSnackBar(errorMessage);
                        loginFrom.isLoading = false;
                      }
                    },
              child: const Text('Registrarse'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: const Text('Iniciar sesion'),
            ),
          ],
        ),
      ),
    );
  }
}
