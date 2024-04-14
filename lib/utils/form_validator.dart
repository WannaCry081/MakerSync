class FormValidator {

  String? validateEmail(String? value) {
    RegExp expression = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        caseSensitive: false);

    if (value == null || value.isEmpty) {
      return "Email Address is Required";
    }

    if (!expression.hasMatch(value)) {
      return "Invalid Email Address. Please try again.";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is Required";
    }

    if (value.length < 8) {
      return "Password must at least be 8 characters long.";
    }

    return null;
  }

}