class Transaction {
  final double amount;
  final DateTime dateTime;
  final String type; // 'Recharge' or 'Charge'

  Transaction(this.amount, this.type, {DateTime? dateTime})
      : dateTime = dateTime ?? DateTime.now();
}

class Vehicle {
  final String licensePlate;
  final String make;

  Vehicle({
    required this.licensePlate,
    required this.make,
  });
}

class PaymentMethod {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate; // Formatted as MM/YY
  final String cvv;

  PaymentMethod({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
  });
}

class User {
  final String name;
  final String email;
  String phone;
  String password;
  double balance;
  String? profileImagePath; // Nueva propiedad para la imagen de perfil
  List<PaymentMethod> paymentMethods;
  List<Vehicle> vehicles;
  List<Transaction> transactions;

  User({
    required this.name,
    required this.email,
    this.phone = '',
    this.password = '',
    this.balance = 0.0,
    this.profileImagePath, // Inicializa la propiedad
    List<PaymentMethod>? paymentMethods,
    List<Vehicle>? vehicles,
  })  : paymentMethods = paymentMethods ?? [],
        vehicles = vehicles ?? [],
        transactions = [];

  void updateUser({
    String? newName,
    String? newEmail,
    String? newPhone,
    String? newPassword,
    String? newProfileImagePath, // Agregar parámetro para la imagen de perfil
  }) {
    if (newName != null) {
      // Manejo de inmutabilidad si name es final
      // No puedes cambiar el valor de name porque es final.
      // Considera usar un método diferente si necesitas cambiarlo.
    }
    if (newEmail != null) {
      // Manejo de inmutabilidad si email es final
      // No puedes cambiar el valor de email porque es final.
      // Al igual que con name, considera otro enfoque.
    }
    if (newPhone != null) {
      phone = newPhone;
    }
    if (newPassword != null) {
      password = newPassword;
    }
    if (newProfileImagePath != null) {
      profileImagePath = newProfileImagePath; // Actualiza la imagen de perfil
    }
  }

  void addPaymentMethod(String cardNumber, String cardHolderName, String expiryDate, String cvv) {
    paymentMethods.add(PaymentMethod(
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvv: cvv,
    ));
  }

  void removePaymentMethod(String cardNumber) {
    paymentMethods.removeWhere((paymentMethod) => paymentMethod.cardNumber == cardNumber);
  }

  List<PaymentMethod> getPaymentMethods() {
    return paymentMethods;
  }

  void addVehicle(String licensePlate, String make) {
    vehicles.add(Vehicle(licensePlate: licensePlate, make: make));
  }

  void removeVehicle(String licensePlate) {
    vehicles.removeWhere((vehicle) => vehicle.licensePlate == licensePlate);
  }

  List<Vehicle> getVehicles() {
    return vehicles;
  }

  void addTransaction(double amount, String type) {
    transactions.add(Transaction(amount, type));
  }

  List<Transaction> getTransactions() {
    return transactions;
  }

  String getTransactionHistory() {
    return transactions.map((transaction) {
      String formattedDate = '${transaction.dateTime.day}/${transaction.dateTime.month}/${transaction.dateTime.year} - ${transaction.dateTime.hour}:${transaction.dateTime.minute}';
      return '${transaction.type}: \$${transaction.amount.toStringAsFixed(2)} (Fecha: $formattedDate)';
    }).join('\n');
  }
}