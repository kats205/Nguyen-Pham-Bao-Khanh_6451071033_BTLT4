class Cau2Model {
  String fullName = "";
  int age = 0;
  String gender = "Nam";
  String maritalStatus = "Độc thân";
  double income = 15.0;

  bool get isValid => fullName.isNotEmpty && age > 0;
}