import 'package:app_peaje/home_screen.dart';
import 'package:app_peaje/registerScreen.dart';
import 'package:app_peaje/recover_password_screen.dart'; // Importa la pantalla de recuperación
import 'package:app_peaje/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:app_peaje/user.dart'; // Importa la clase User

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isPasswordVisible = false; // Para mostrar/ocultar la contraseña
  bool _isEmailValid = false; // Para verificar la validez del correo

  bool _validateEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  bool _validatePassword(String password) {
    if (password.length < 8 || password.length > 12) return false;
    RegExp specialCharacterRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    RegExp uppercaseRegExp = RegExp(r'[A-Z]');
    return specialCharacterRegExp.hasMatch(password) && uppercaseRegExp.hasMatch(password);
  }

  void _handleSignIn() {
    setState(() {
      _errorMessage = null; // Reiniciar el mensaje de error
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    if (!_validateEmail(email)) {
      setState(() {
        _isEmailValid = false; // Correo no válido
        _errorMessage = 'Por favor, introduce un correo electrónico válido.';
      });
      return;
    } else {
      setState(() {
        _isEmailValid = true; // Correo válido
      });
    }

    if (!_validatePassword(password)) {
      setState(() {
        _errorMessage = 'La contraseña debe tener entre 8 y 12 caracteres, un carácter especial y al menos una letra mayúscula.';
      });
      return;
    }

    // Crear un objeto de usuario después de un inicio de sesión exitoso
    User user = User(name: 'Juan Pérez', email: email); // Cambia 'Juan Pérez' por el nombre real del usuario

    // Si las validaciones son correctas, navegar a la pantalla principal
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainHomeScreen(user: user)), // Pasar el usuario
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF751aff),
                Color(0xFFff80ff),
              ]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 22),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                        ),
                      ),
                      const Text(
                        'Bienvenido\nInicia Sesión!',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView( // Agregado para permitir el desplazamiento
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height, // Ajustado para ocupar toda la altura
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      onChanged: (value) {
                        setState(() {
                          _isEmailValid = _validateEmail(value); // Validar el correo mientras se escribe
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          _isEmailValid ? Icons.check : Icons.person,
                          color: _isEmailValid ? Colors.green : Colors.grey,
                        ),
                        label: const Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF751aff),
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        label: const Text(
                          'Contraseña',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF751aff),
                          ),
                        ),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RecoverPasswordScreen()),
                        );
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xff281537),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70),
                    GestureDetector(
                      onTap: _handleSignIn,
                      child: Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF751aff),
                              Color(0xFFff80ff),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 150),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "¿No tienes una cuenta?",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            Text(
                              "Regístrate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
}