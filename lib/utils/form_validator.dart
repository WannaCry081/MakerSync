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

}