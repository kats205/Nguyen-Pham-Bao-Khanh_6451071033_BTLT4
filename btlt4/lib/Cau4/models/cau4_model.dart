class Cau4Model {
  DateTime? selectedDate;
  String? selectedTime;
  String? selectedService = "Kiểm tra tổng quát";

  bool get isDateValid {
    if (selectedDate == null) return false;
    final today = DateTime.now();
    return selectedDate!.isAfter(today.subtract(const Duration(days: 1)));
  }

  bool get isValid => isDateValid && selectedTime != null && selectedService != null;
}