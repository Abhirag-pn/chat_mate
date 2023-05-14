String? emailValidator(String? email) {
  email = email!.trim();
  email = email.toLowerCase();
  if (email.isEmpty || !email.contains("@")) {
    return " Entered email is invalid";
  }
  return null;
}

String? passwordValidator(String? password) {
  password=password!.trim();
  if (password.isEmpty || password.length < 8) {
    return "Should be minimum of 8 characters";
  }
  return null;
}
