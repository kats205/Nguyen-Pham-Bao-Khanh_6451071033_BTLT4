import 'package:flutter/material.dart';
class StudentInfoWidget extends StatelessWidget {
  const StudentInfoWidget({super.key});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(8)
    ),
    child: const Text('MSSV: 6451071033', style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold)),
  );
}