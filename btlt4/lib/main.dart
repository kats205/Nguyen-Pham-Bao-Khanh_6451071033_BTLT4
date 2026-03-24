import 'package:flutter/material.dart';

// Imports của từng bài tập
import 'Cau1/apps/cau1_app.dart';
import 'Cau2/apps/cau2_app.dart';
import 'Cau3/apps/cau3_app.dart';
import 'Cau4/apps/cau4_app.dart';
import 'Cau5/apps/cau5_app.dart';
import 'Cau6/apps/cau6_app.dart';
import 'Cau7/apps/cau7_app.dart';
import 'Cau8/apps/cau8_app.dart';
import 'Cau9/apps/cau9_app.dart';
import 'Cau10/apps/cau10_app.dart';

void main() {
  runApp(const MyApp());
}

const String studentID = "6451071033"; // Thay đổi MSSV tại đây
const String studentName = "Nguyễn Phạm Bảo Khanh"; // Thay đổi Tên tại đây

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tập bài tập Dart - $studentID',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Bài tập Dart'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildInfoCard(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.list_alt, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text("Chọn bài tập để xem nội dung:", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 70),
              itemBuilder: (context, index) {
                int id = index + 1;
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text('$id', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  ),
                  title: Text('Câu số $id', style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () => _navigateToExercise(context, id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToExercise(BuildContext context, int id) {
    Widget destination;
    switch (id) {
      case 1: destination = const Cau1App(); break;
      case 2: destination = const Cau2App(); break;
      case 3: destination = const Cau3App(); break;
      case 4: destination = const Cau4App(); break;
      case 5: destination = const Cau5App(); break;
      case 6: destination = const Cau6App(); break;
      case 7: destination = const Cau7App(); break;
      case 8: destination = const Cau8App(); break;
      case 9: destination = const Cau9App(); break;
      case 10: destination = const Cau10App(); break;
      default: return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline, size: 20, color: Colors.blue),
              const SizedBox(width: 10),
              const Text("Họ tên: ", style: TextStyle(fontWeight: FontWeight.w600)),
              Text(studentName),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.badge_outlined, size: 20, color: Colors.blue),
              const SizedBox(width: 10),
              const Text("MSSV: ", style: TextStyle(fontWeight: FontWeight.w600)),
              Text(studentID, style: const TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
