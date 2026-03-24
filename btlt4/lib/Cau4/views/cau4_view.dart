import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/cau4_model.dart';
import '../widget/cau4_widget.dart';

class Cau4View extends StatefulWidget {
  const Cau4View({super.key});

  @override
  State<Cau4View> createState() => _Cau4ViewState();
}

class _Cau4ViewState extends State<Cau4View> {
  final _model = Cau4Model();
  String? _dateError;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _model.selectedDate = picked;
        _dateError = _model.isDateValid ? null : 'Ngày không hợp lệ (trong quá khứ)';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _model.selectedTime = picked.format(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ĐẶT LỊCH HẸN'),
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Chọn ngày', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                hintText: _model.selectedDate == null ? 'Select Date' : DateFormat('dd/MM/yyyy').format(_model.selectedDate!),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(icon: const Icon(Icons.calendar_month, color: Colors.brown), onPressed: () => _selectDate(context)),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (_dateError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.orange, size: 16),
                    const SizedBox(width: 8),
                    Text(_dateError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                  ],
                ),
              ),
              
            const SizedBox(height: 16),
            const Text('Chọn giờ', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              readOnly: true,
              onTap: () => _selectTime(context),
              decoration: InputDecoration(
                hintText: _model.selectedTime ?? 'Chọn giờ',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(icon: const Icon(Icons.access_time, color: Colors.grey), onPressed: () => _selectTime(context)),
              ),
            ),
            
            const SizedBox(height: 16),
            const Text('Chọn dịch vụ', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _model.selectedService,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: ['Kiểm tra tổng quát', 'Dịch vụ 2', 'Dịch vụ 3'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _model.selectedService = v!),
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _model.isValid ? () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đặt lịch thành công!')));
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('Xác nhận Đặt lịch'),
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