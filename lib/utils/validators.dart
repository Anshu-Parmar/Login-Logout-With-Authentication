extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r"^([A-Za-z]+([.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidPincode {
    final pincodeRegExp = RegExp(r"^\d{6}$");
    return pincodeRegExp.hasMatch(this);
  }

  bool get isNumeric {
    RegExp numericRegExp = RegExp(r"^[0-9]+$");
    return numericRegExp.hasMatch(this);
  }

}