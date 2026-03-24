import 'package:flutter/material.dart';
import '../models/cau2_model.dart';
import '../widget/cau2_widget.dart';

class Cau2View extends StatefulWidget {
  const Cau2View({super.key});

  @override
  State<Cau2View> createState() => _Cau2ViewState();
}

class _Cau2ViewState extends State<Cau2View> {
  final _formKey = GlobalKey<FormState>();
  final _model = Cau2Model();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORM THÔNG TIN CÁ NHÂN'),
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Họ và tên', hintText: 'Nhập tên của bạn'),
                onChanged: (v) => _model.fullName = v,
                validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập họ và tên' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tuổi',
                  hintText: 'Nhập tuổi của bạn',
                  errorStyle: TextStyle(color: Colors.red),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) => _model.age = int.tryParse(v) ?? 0,
                validator: (v) {
                  int val = int.tryParse(v ?? "") ?? -1;
                  return (val <= 0) ? 'Tuổi phải > 0' : null;
                },
              ),
              const SizedBox(height: 16),
              
              const Text('Giới tính', style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                value: _model.gender,
                items: ['Nam', 'Nữ', 'Khác'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _model.gender = v!),
              ),
              const SizedBox(height: 16),
              
              const Text('Tình trạng hôn nhân', style: TextStyle(fontWeight: FontWeight.bold)),
              RadioListTile(
                title: const Text('Độc thân'),
                value: 'Độc thân',
                groupValue: _model.maritalStatus,
                onChanged: (v) => setState(() => _model.maritalStatus = v!),
              ),
              RadioListTile(
                title: const Text('Kết hôn'),
                value: 'Kết hôn',
                groupValue: _model.maritalStatus,
                onChanged: (v) => setState(() => _model.maritalStatus = v!),
              ),
              RadioListTile(
                title: const Text('Ly hôn'),
                value: 'Ly hôn',
                groupValue: _model.maritalStatus,
                onChanged: (v) => setState(() => _model.maritalStatus = v!),
              ),
              const SizedBox(height: 16),
              
              Text('Mức thu nhập: ${_model.income.toInt()} tr VND', style: const TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                value: _model.income,
                min: 0,
                max: 100,
                divisions: 10,
                label: '${_model.income.toInt()} tr VND',
                onChanged: (v) => setState(() => _model.income = v),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('0\ntr VND'),
                  Text('10\ntr VND'),
                  Text('20\ntr VND'),
                  Text('...\ntr VND'),
                ],
              ),
              const SizedBox(height: 32),
              const Center(child: StudentInfoWidget()), // MSSV
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã lưu thông tin!')));
          }
        },
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
        child: const Icon(Icons.save),
      ),
    );
  }
}