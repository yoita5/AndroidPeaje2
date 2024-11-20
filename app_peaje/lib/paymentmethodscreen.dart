import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar para usar TextInputFormatter
import 'package:app_peaje/user.dart';

class PaymentMethodScreen extends StatefulWidget {
  final User user;

  const PaymentMethodScreen({super.key, required this.user});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool _isCardNumberValid = false;
  bool _isCardHolderNameValid = false;
  bool _isExpiryDateValid = false;
  bool _isCvvValid = false;

  bool _validateCardNumber(String cardNumber) {
    return cardNumber.length == 16; // Validación básica
  }

  bool _validateCardHolderName(String name) {
    return name.isNotEmpty; // Validación básica
  }

  bool _validateExpiryDate(String expiryDate) {
    return RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(expiryDate);
  }

  bool _validateCvv(String cvv) {
    return cvv.length == 3; // Validación básica
  }

  void _savePaymentMethod() {
    if (_formKey.currentState?.validate() ?? false) {
      // Aquí debes definir cómo crear el método de pago
      PaymentMethod newPaymentMethod = PaymentMethod(
        cardNumber: _cardNumberController.text,
        cardHolderName: _cardHolderNameController.text,
        expiryDate: _expiryDateController.text,
        cvv: _cvvController.text,
      );

      widget.user.addPaymentMethod(
        newPaymentMethod.cardNumber,
        newPaymentMethod.cardHolderName,
        newPaymentMethod.expiryDate,
        newPaymentMethod.cvv,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Método de pago agregado con éxito.')),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF751aff),
              Color(0xFFff80ff),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Métodos de Pago',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _cardNumberController,
                      label: 'Número de Tarjeta',
                      isValid: _isCardNumberValid,
                      onChanged: (value) {
                        setState(() {
                          _isCardNumberValid = _validateCardNumber(value);
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _cardHolderNameController,
                      label: 'Nombre del Titular',
                      isValid: _isCardHolderNameValid,
                      onChanged: (value) {
                        setState(() {
                          _isCardHolderNameValid = _validateCardHolderName(value);
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _expiryDateController,
                            label: 'Fecha de Expiración (MM/AA)',
                            isValid: _isExpiryDateValid,
                            onChanged: (value) {
                              setState(() {
                                _isExpiryDateValid = _validateExpiryDate(value);
                              });
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              _ExpiryDateFormatter(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            controller: _cvvController,
                            label: 'CVV',
                            isValid: _isCvvValid,
                            onChanged: (value) {
                              setState(() {
                                _isCvvValid = _validateCvv(value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 300,
                      child: OutlinedButton(
                        onPressed: _savePaymentMethod,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.grey, width: 1.5), // Borde gris
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Guardar Método de Pago',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFFAB47BC),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isValid,
    void Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters, // Agregar este parámetro
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      inputFormatters: inputFormatters, // Aplicar el formateador aquí
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: Icon(
          isValid ? Icons.check : Icons.card_giftcard,
          color: isValid ? Colors.green : Colors.grey,
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
        filled: true,
        fillColor: const Color(0xFFF0F0F0), // Color de fondo de los campos
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFFAB47BC)),
        ),
      ),
    );
  }
}

// Formateador para la fecha de expiración
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Si el nuevo valor está vacío, no hacer nada
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Formatear la entrada
    final StringBuffer newText = StringBuffer();
    String text = newValue.text.replaceAll('/', '');

    for (int i = 0; i < text.length; i++) {
      // Agregar el carácter actual
      newText.write(text[i]);
      // Si hemos agregado dos caracteres, agregar un '/'
      if (i == 1) {
        newText.write('/');
      }
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.toString().length),
    );
  }
}