import 'package:book/presentation/blocs/authentication/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagen
              Image.asset(
                'assets/login_image.png', // Asegúrate de tener esta imagen en tus assets
                height: 200,
              ),
              SizedBox(height: 24),

              // Texto de incitación
              Text(
                'Bienvenido, por favor inicia sesión',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),

              // Botón de Google
              ElevatedButton.icon(
                onPressed: () {
                  // Lógica para iniciar sesión con Google
                  BlocProvider.of<AuthBloc>(context).add(SignInWithGoogle());
                },
                icon: Image.asset('assets/google_icon.png',
                    height:
                        18.0), // Asegúrate de tener este ícono en tus assets
                label: Text('Iniciar sesión con Google'),
              ),
              SizedBox(height: 16),

              // Botón de Apple
              ElevatedButton.icon(
                onPressed: () {
                  // Lógica para iniciar sesión con Apple
                  BlocProvider.of<AuthBloc>(context).add(SignInWithApple());
                },
                icon: Image.asset('assets/apple_icon.png',
                    height:
                        18.0), // Asegúrate de tener este ícono en tus assets
                label: Text('Iniciar sesión con Apple'),
              ),
              SizedBox(height: 24),

              // Link a términos y condiciones
              TextButton(
                onPressed: () {
                  // Navegar a la pantalla de términos y condiciones
                },
                child: Text(
                  'Términos y condiciones',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
