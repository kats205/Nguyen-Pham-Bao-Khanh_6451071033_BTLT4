class Cau10Model {
  String fullName = "";
  String email = "";
  String phone = "";
  double experience = 5.0;
  String gender = "Male";
  String country = "Vietnam";
  DateTime? dob;
  String? cvFileName;
  bool isPython = true;
  bool isDart = false;
  bool isProjectManagement = false;

  bool isSubmitting = false;

  bool get isValid => 
      fullName.isNotEmpty && 
      email.contains('@') && 
      phone.length >= 10 && 
      dob != null && 
      cvFileName != null;
}