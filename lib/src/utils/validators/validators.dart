class Validators {
  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? validateNumber(String? value, String? label) {
    String pattern = r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return '$label cannot be empty';
    }
    if (!regex.hasMatch(value)) {
      return '$label is not a number';
    } else {
      return null;
    }
  }

  static String? validateName(String? value, String? label) {
    if (value!.isEmpty) {
      return '$label cannot be empty';
    }
    if (value.length < 3) {
      return '$label must be more than 2 charater';
    } else {
      return null;
    }
  }

  static String? validateNotEmpty(String? value, String? label) {
    if (value!.isEmpty) {
      return '$label cannot be empty';
    }

    return null;
  }

  static String? validatePassword(String? value, String? label) {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (value!.isEmpty) {
      return '$label cannot be empty';
    }
    if (value.length < 8) {
      return '$label must be more than 8 charater';
    } else if (!passwordRegExp.hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number, and 1 special character.';
    } else {
      return null;
    }
  }

  static String? validateSGPhone(String? value, String? label) {
    final singaporePhoneRegExp = RegExp(r'^[789]\d{7}$');
    if (value!.isEmpty) {
      return '$label cannot be empty';
    }
    if (!singaporePhoneRegExp.hasMatch(value)) {
      return 'Invalid Singapore phone number format.';
    } else {
      return null;
    }
  }

  static String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  static String? validatePostcode(String? value) {
    final regExp = RegExp(r"^[0-9]{6}$");

    if (value!.isEmpty) {
      return 'Postal code cannot be empty';
    }
    if (!regExp.hasMatch(value)) {
      return 'Invalid portal code';
    } else {
      return null;
    }
  }
}
