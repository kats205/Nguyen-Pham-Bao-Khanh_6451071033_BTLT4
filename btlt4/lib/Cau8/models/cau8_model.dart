class Cau8Model {
  int currentStep = 0;
  
  // Step 1: Cá nhân
  String fullName = "";
  String email = "";
  String address = "";
  
  // Step 2: Sở thích
  double preferenceValue = 50.0;
  List<String> selectedInterests = [];

  bool isStep1Valid() => fullName.isNotEmpty && email.contains('@') && address.isNotEmpty;
  bool isStep2Valid() => selectedInterests.isNotEmpty;
  
  bool get isValid => isStep1Valid() && isStep2Valid();
}