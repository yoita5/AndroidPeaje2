import 'package:flutter/material.dart';
import 'package:app_peaje/login_page.dart';
import 'package:app_peaje/registerScreen.dart';
import 'package:app_peaje/welcomeScreen.dart';
import 'package:app_peaje/home_screen.dart' as home_screen;
import 'package:app_peaje/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Crea un objeto User de ejemplo
    final myUser = User(
      name: 'Juan Perez',
      email: 'juan.perez@example.com',
      balance: 1847.56,
    );

    return MaterialApp(
      title: 'App Peaje',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterScreen(),
        '/homepage': (context) => home_screen.MainHomeScreen(user: myUser),
      },
      // Manejo de errores de navegación
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
      },
    );
  }
}