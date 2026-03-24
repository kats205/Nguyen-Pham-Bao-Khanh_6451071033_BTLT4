class Cau7Model {
  String name = "Nguyen Lan Huong";
  String bio = "Mobile Developer";
  String gender = "Female";
  String? avatarPath;

  bool get isValid => name.isNotEmpty && bio.isNotEmpty;
}