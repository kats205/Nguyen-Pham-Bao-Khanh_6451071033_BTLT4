class Cau6Model {
  String fullName = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  String get passwordStrength {
    if (password.isEmpty) return "";
    if (password.length < 6) return "Rất yếu";
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) return "Hơi yếu, hãy thêm ký tự đặc biệt";
    return "Mạnh";
  }

  bool get isPasswordMatch => password == confirmPassword && password.isNotEmpty;

  bool get isValid => 
      fullName.isNotEmpty && 
      email.isNotEmpty && 
      password.length >= 6 && 
      isPasswordMatch &&
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}