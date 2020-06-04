
class FormValidators{
    static String emailValidator(value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    } else if (!value.contains("@")) {
      return "Enter valid email";
    }
    return null;
  }

  static String passwordValidator(value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be of greater than 6 character';
    }
    return null;
  }
  static String urlValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter url';
    }
    else if (!value.contains('http')) {
      return 'Please enter valid url';
    }

    return null;
  }

  static String phoneNumberValidator(value) {
    if (value.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.length != 10 ) {
      return 'Phone number must be of 10 digit';
    }
    return null;
  }
}
