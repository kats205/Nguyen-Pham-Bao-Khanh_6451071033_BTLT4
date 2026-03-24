class Cau1Model {
  String fullName = "";
  String email = "";
  String password = "";
  bool agreeToTerms = false;

  bool get isValid => 
      fullName.isNotEmpty && 
      email.isNotEmpty && 
      password.isNotEmpty && 
      agreeToTerms && 
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}