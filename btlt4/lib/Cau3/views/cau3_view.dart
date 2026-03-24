import 'package:flutter/material.dart';
import '../models/cau3_model.dart';
import '../widget/cau3_widget.dart';

class Cau3View extends StatefulWidget {
  const Cau3View({super.key});

  @override
  State<Cau3View> createState() => _Cau3ViewState();
}

class _Cau3ViewState extends State<Cau3View> {
  final _model = Cau3Model();
  String? _checkboxError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('SỞ THÍCH (INTERESTS)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            ..._model.interests.keys.map((key) => CheckboxListTile(
              secondary: Icon(_getIcon(key)),
              title: Text(key),
              value: _model.interests[key],
              onChanged: (v) => setState(() {
                _model.interests[key] = v ?? false;
                _checkboxError = _model.isCheckboxValid ? null : 'Bạn phải chọn ít nhất 1 sở thích';
              }),
              controlAffinity: ListTileControlAffinity.trailing,
            )),
            
            if (_checkboxError != null)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Text(_checkboxError!, style: const TextStyle(color: Colors.red)),
                  ],
                ),
              ),
              
            const SizedBox(height: 16),
            const Text('MỨC ĐỘ HÀI LÒNG (SATISFACTION LEVEL)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            RadioListTile<String>(
              secondary: const Icon(Icons.sentiment_satisfied),
              title: const Text('Hài lòng (Satisfied)'),
              value: 'Satisfied',
              groupValue: _model.satisfaction,
              onChanged: (v) => setState(() => _model.satisfaction = v!),
            ),
            RadioListTile<String>(
              secondary: const Icon(Icons.sentiment_neutral),
              title: const Text('Bình thường (Neutral)'),
              value: 'Neutral',
              groupValue: _model.satisfaction,
              onChanged: (v) => setState(() => _model.satisfaction = v!),
            ),
            RadioListTile<String>(
              secondary: const Icon(Icons.sentiment_dissatisfied),
              title: const Text('Chưa hài lòng (Unsatisfied)'),
              value: 'Unsatisfied',
              groupValue: _model.satisfaction,
              onChanged: (v) => setState(() => _model.satisfaction = v!),
            ),
            
            const SizedBox(height: 16),
            const Text('GHI CHÚ THÊM (ADDITIONAL NOTES)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Ghi chú thêm...'),
              onChanged: (v) => _model.notes = v,
            ),
            
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  if (!_model.isCheckboxValid) {
                    setState(() => _checkboxError = 'Bạn phải chọn ít nhất 1 sở thích');
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cảm ơn phản hồi của bạn!')));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                child: const Text('Gửi Khảo Sát'),
              ),
            ),
            const SizedBox(height: 32),
            const Center(child: StudentInfoWidget()),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String key) {
    if (key.contains('Movies')) return Icons.movie;
    if (key.contains('Sports')) return Icons.sports_basketball;
    if (key.contains('Music')) return Icons.music_note;
    return Icons.travel_explore;
  }
}