import 'package:flutter/material.dart';
import '../models/cau9_model.dart';
import '../widget/cau9_widget.dart';

class Cau9View extends StatefulWidget {
  const Cau9View({super.key});

  @override
  State<Cau9View> createState() => _Cau9ViewState();
}

class _Cau9ViewState extends State<Cau9View> {
  final _model = Cau9Model();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm Số Điện Thoại'),
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Thông tin liên hệ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _model.controllers.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Số điện thoại ${index + 1}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        Row(
                          children: [
                            const Icon(Icons.phone),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _model.controllers[index],
                                decoration: InputDecoration(
                                  hintText: '+84 912345678',
                                  errorText: _model.errors[index],
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.phone,
                                onChanged: (v) => setState(() => _model.validate(index)),
                              ),
                            ),
                            if (_model.errors[index] == null && _model.controllers[index].text.isNotEmpty)
                              const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 12),
                            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => setState(() => _model.removePhone(index))),
                          ],
                        ),
                        if (_model.errors[index] != null)
                          Text(_model.errors[index]!, style: const TextStyle(color: Colors.red, fontSize: 10)),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => setState(() => _model.addPhone()),
              icon: const Icon(Icons.add),
              label: const Text('Thêm số điện thoại'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B4042), foregroundColor: Colors.white),
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _model.isValid ? () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cập nhật thông tin thành công!')));
                } : null,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B4042), foregroundColor: Colors.white),
                child: const Text('Submit Tất Cả'),
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