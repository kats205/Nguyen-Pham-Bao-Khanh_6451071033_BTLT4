import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../models/cau5_model.dart';
import '../widget/cau5_widget.dart';

class Cau5View extends StatefulWidget {
  const Cau5View({super.key});

  @override
  State<Cau5View> createState() => _Cau5ViewState();
}

class _Cau5ViewState extends State<Cau5View> {
  final _model = Cau5Model();
  String? _fileError;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null) {
      setState(() {
        _model.fileName = result.files.single.name;
        _fileError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 5: Form upload hồ sơ'),
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Họ và tên', style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Full Name'),
              onChanged: (v) => _model.fullName = v,
            ),
            const SizedBox(height: 16),
            
            const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Hint Email'),
              onChanged: (v) => _model.email = v,
            ),
            const SizedBox(height: 16),
            
            const Text('File Picker', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('CV (Định dạng: PDF, DOCX)', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.red[200]!), borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickFile,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200], foregroundColor: Colors.black),
                    child: const Text('Chọn Tệp CV'),
                  ),
                  const SizedBox(width: 12),
                  if (_model.fileName != null)
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
                          const SizedBox(width: 4),
                          Expanded(child: Text(_model.fileName!, overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (_fileError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(_fileError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
              ),
              
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Tôi xác nhận thông tin là chính xác.'),
              value: _model.isConfirmed,
              onChanged: (v) => setState(() => _model.isConfirmed = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_model.fileName == null) {
                    setState(() => _fileError = 'Vui lòng upload CV của bạn!');
                    return;
                  }
                  if (_model.fullName.isEmpty || _model.email.isEmpty || !_model.isConfirmed) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng hoàn thành đủ form!')));
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nộp hồ sơ thành công!')));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2A96D),
                  disabledBackgroundColor: const Color(0xFFF2A96D).withOpacity(0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('Nộp Hồ Sơ', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 32),
            const Center(child: StudentInfoWidget()),
          ],
        ),
      ),
    );
  }
}