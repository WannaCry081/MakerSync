class FormValidator {

  String? validateEmail(String? value) {
    RegExp expression = RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        caseSensitive: false);

    if (value == null || value.isEmpty) {
      return "Email address is required";
    }

    if (!expression.hasMatch(value)) {
      return "Invalid email address. Please try again.";
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

  String? validateConfirmPassword(String?value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is Required";
    }

    if (password != value) {
      return "Password does not match";
    }

    return null;
  }

  String? validateInput(String? value, String name, int minLength, int maxLength) {
    if (value == null || value.isEmpty) {
      return "$name is Required";
    }

    if (value.length < minLength) {
      return "$name must at least be $minLength characters long.";
    }

    if (value.length > maxLength) {
      return "$name must at least be $maxLength characters long.";
    }

    return null;
  }


}