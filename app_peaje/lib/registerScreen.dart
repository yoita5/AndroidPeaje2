import 'package:app_peaje/home_screen.dart';
import 'package:app_peaje/login_page.dart';
import 'package:app_peaje/user.dart';
import 'package:app_peaje/welcomeScreen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _errorMessage;
  bool _isNameValid = false;
  bool _isPhoneValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool _validateEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    String phonePattern = r'^\+?[0-9]{10,15}$';
    RegExp regExp = RegExp(phonePattern);
    return regExp.hasMatch(phone);
  }

  bool _validatePassword(String password) {
    if (password.length < 8 || password.length > 12) return false;
    RegExp specialCharacterRegExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    RegExp uppercaseRegExp = RegExp(r'[A-Z]');
    return specialCharacterRegExp.hasMatch(password) && uppercaseRegExp.hasMatch(password);
  }

  void _handleSignUp() {
    setState(() {
      _errorMessage = null;
      _isNameValid = _nameController.text.trim().isNotEmpty;
      _isPhoneValid = _validatePhone(_phoneController.text.trim());
      _isEmailValid = _validateEmail(_emailController.text.trim());
      _isPasswordValid = _validatePassword(_passwordController.text.trim());
      _isConfirmPasswordValid = _passwordController.text.trim() == _confirmPasswordController.text.trim();
    });

    if (!_isNameValid) {
      setState(() {
        _errorMessage = 'Por favor, ingresa tu nombre completo.';
      });
      return;
    }

    if (!_isPhoneValid) {
      setState(() {
        _errorMessage = 'Por favor, ingresa un número de teléfono válido.';
      });
      return;
    }

    if (!_isEmailValid) {
      setState(() {
        _errorMessage = 'Por favor, introduce un correo electrónico válido.';
      });
      return;
    }

    if (!_isPasswordValid) {
      setState(() {
        _errorMessage = 'La contraseña debe tener entre 8 y 12 caracteres, un carácter especial y al menos una letra mayúscula.';
      });
      return;
    }

    if (!_isConfirmPasswordValid) {
      setState(() {
        _errorMessage = 'Las contraseñas no coinciden.';
      });
      return;
    }

    // Si todas las validaciones son correctas, crear un objeto User y navegar a MainHomeScreen
    User newUser = User(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainHomeScreen(user: newUser)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                        );
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Crea Tu\nCuenta',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _nameController,
                        onChanged: (value) {
                          setState(() {
                            _isNameValid = value.isNotEmpty;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            _isNameValid ? Icons.check : Icons.person,
                            color: _isNameValid ? Colors.green : Colors.grey,
                          ),
                          label: const Text(
                            'Nombre Completo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF751aff),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _phoneController,
                        onChanged: (value) {
                          setState(() {
                            _isPhoneValid = _validatePhone(value);
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            _isPhoneValid ? Icons.check : Icons.phone,
                            color: _isPhoneValid ? Colors.green : Colors.grey,
                          ),
                          label: const Text(
                            'Teléfono',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF751aff),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _emailController,
                        onChanged: (value) {
                          setState(() {
                            _isEmailValid = _validateEmail(value);
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            _isEmailValid ? Icons.check : Icons.email,
                            color: _isEmailValid ? Colors.green : Colors.grey,
                          ),
                          label: const Text(
                            'Correo Electrónico',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF751aff),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        onChanged: (value) {
                          setState(() {
                            _isPasswordValid = _validatePassword(value);
                            _isConfirmPasswordValid = value == _confirmPasswordController.text.trim();
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        onChanged: (value) {
                          setState(() {
                            _isConfirmPasswordValid = value == _passwordController.text.trim();
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          label: const Text(
                            'Confirmar Contraseña',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF751aff),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: _handleSignUp,
                        child: Container(
                          height: 55,
                          width: double.infinity,
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
                              'REGISTRARSE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "¿Ya tienes una cuenta?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Iniciar Sesión",
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
      ),
    );
  }
}