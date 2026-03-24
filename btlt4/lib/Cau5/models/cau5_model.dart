class Cau5Model {
  String fullName = "";
  String email = "";
  String? fileName;
  bool isConfirmed = false;

  bool get isValid => fullName.isNotEmpty && email.isNotEmpty && fileName != null && isConfirmed;
}