import 'package:flutter/material.dart';

class Cau9Model {
  List<TextEditingController> controllers = [TextEditingController()];
  List<String?> errors = [null];

  bool get isValid => controllers.every((c) => c.text.length >= 10);

  void addPhone() {
    controllers.add(TextEditingController());
    errors.add(null);
  }

  void removePhone(int index) {
    if (controllers.length > 1) {
      controllers.removeAt(index);
      errors.removeAt(index);
    }
  }

  void validate(int index) {
    if (controllers[index].text.length < 10) {
      errors[index] = 'Số điện thoại phải có ít nhất 10 chữ số.';
    } else {
      errors[index] = null;
    }
  }
}