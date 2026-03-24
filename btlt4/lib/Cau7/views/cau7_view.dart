import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../models/cau7_model.dart';
import '../widget/cau7_widget.dart';

class Cau7View extends StatefulWidget {
  const Cau7View({super.key});

  @override
  State<Cau7View> createState() => _Cau7ViewState();
}

class _Cau7ViewState extends State<Cau7View> {
  final _model = Cau7Model();

  Future<void> _pickAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() => _model.avatarPath = result.files.single.path);
    }
  }

  void _showSubmitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile Update'),
        content: const Text('Are you sure you want to save changes?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully!')));
            },
            child: const Text('Yes, Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
        actions: const [Icon(Icons.account_circle), SizedBox(width: 16)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                   CircleAvatar(
                    radius: 60,
                    backgroundImage: _model.avatarPath != null ? FileImage(File(_model.avatarPath!)) : null,
                    child: _model.avatarPath == null ? const Icon(Icons.person, size: 60) : null,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickAvatar,
              icon: const Icon(Icons.photo_library),
              label: const Text('Change Avatar'),
              style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF1B4042)),
            ),
            const SizedBox(height: 32),
            
            _buildInfoBox('Full Name', _model.name, Icons.person, (v) => _model.name = v),
            const SizedBox(height: 16),
            _buildInfoBox('Bio', _model.bio, Icons.description, (v) => _model.bio = v),
            const SizedBox(height: 16),
            
            DropdownButtonFormField<String>(
              value: _model.gender,
              decoration: const InputDecoration(labelText: 'Gender', prefixIcon: Icon(Icons.wc), border: OutlineInputBorder()),
              items: ['Female', 'Male', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _model.gender = v!),
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _model.isValid ? _showSubmitDialog : null,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B4042), foregroundColor: Colors.white),
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCDA057), foregroundColor: Colors.white),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(height: 32),
            const StudentInfoWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value, IconData icon, Function(String) onChanged) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.withOpacity(0.3))),
      ),
      onChanged: (v) => setState(() => onChanged(v)),
    );
  }
}