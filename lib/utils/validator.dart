class Validator {
  static String? validateName(String? name) {
    if (name!.isEmpty) {
      return 'Name can\'t be empty';
    }
    if (name.isValidPassword) {
      return 'Enter ur full name correctly';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Password can\'t be empty';
    }
    if (password.isValidPassword) {
      return 'Enter a correct password';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Email can\'t be empty';
    }
    if (!email.isValidEmail) {
      return 'Enter a correct email';
    }
    return null;
  }

  static String? validatePhone(String? phoneNumber) {
    if (phoneNumber!.isEmpty) {
      return 'Enter ur phone Number plz';
    }
    if (!phoneNumber.isValidPhone ||
        phoneNumber.length > 16 ||
        phoneNumber.length < 9) {
      return 'Enter ur correct phone number';
    }
    return null;
  }
}

// use extenstion in flutter to add more functionality to existing libs and packages

extension ExtString on String {
  bool get isValidEmail {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(this);
  }

  bool get isValidName {
    return RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
        .hasMatch(this);
  }

  bool get isValidPassword {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>')
        .hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    return RegExp(r"^\+?0[0-9]{10}$").hasMatch(this);
  }
}
