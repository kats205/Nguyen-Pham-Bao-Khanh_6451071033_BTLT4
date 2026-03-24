import 'package:flutter/material.dart';
import '../models/cau8_model.dart';
import '../widget/cau8_widget.dart';

class Cau8View extends StatefulWidget {
  const Cau8View({super.key});

  @override
  State<Cau8View> createState() => _Cau8ViewState();
}

class _Cau8ViewState extends State<Cau8View> {
  final _model = Cau8Model();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  void _onStepContinue() {
    if (_model.currentStep == 0) {
      if (_formKey1.currentState!.validate()) {
        setState(() => _model.currentStep += 1);
      }
    } else if (_model.currentStep == 1) {
      if (_model.isStep2Valid()) {
        setState(() => _model.currentStep += 1);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Vui lòng chọn ít nhất 1 sở thích!')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hồ sơ đã được hoàn thiện!')));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Profile'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.white)))],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildCustomStepIndicator(),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: _buildStepContent(),
            ),
          ),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildCustomStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stepCircle(1, 'Personal Info', _model.currentStep >= 0),
          _stepLine(_model.currentStep >= 1),
          _stepCircle(2, 'Preferences', _model.currentStep >= 1),
          _stepLine(_model.currentStep >= 2),
          _stepCircle(3, 'Confirmation', _model.currentStep >= 2),
        ],
      ),
    );
  }

  Widget _stepCircle(int index, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isActive ? Colors.blue : Colors.grey[300],
          child: Text('$index', style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _stepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16, left: 4, right: 4),
        color: isActive ? Colors.blue : Colors.grey[300],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_model.currentStep) {
      case 0:
        return Form(
          key: _formKey1,
          child: Column(
            children: [
              const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=12')),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                onChanged: (v) => _model.fullName = v,
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập họ tên' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email Address', border: OutlineInputBorder()),
                onChanged: (v) => _model.email = v,
                validator: (v) => (v!.isEmpty || !v.contains('@')) ? 'Email không hợp lệ' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Current Address', border: OutlineInputBorder(), errorStyle: TextStyle(color: Colors.red)),
                onChanged: (v) => _model.address = v,
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập địa chỉ' : null,
              ),
            ],
          ),
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Mức độ yêu thích:', style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: _model.preferenceValue,
              max: 100,
              onChanged: (v) => setState(() => _model.preferenceValue = v),
            ),
            const SizedBox(height: 16),
            const Text('Chọn sở thích:', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              children: [
                _interestChip('Music'),
                _interestChip('Sport'),
                _interestChip('Traveling'),
                _interestChip('Technology'),
              ],
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Xác nhận thông tin:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            _infoRow('Họ tên:', _model.fullName),
            _infoRow('Email:', _model.email),
            _infoRow('Địa chỉ:', _model.address),
            _infoRow('Mức độ yêu thích:', '${_model.preferenceValue.toInt()}%'),
            _infoRow('Sở thích:', _model.selectedInterests.join(', ')),
            const SizedBox(height: 32),
            const Center(child: StudentInfoWidget()),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [Text(label, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(width: 8), Text(value)]),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _onStepContinue,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
              child: Text(_model.currentStep == 2 ? 'Finish' : 'Continue to next step'),
            ),
          ),
          const SizedBox(width: 12),
          TextButton(onPressed: () {}, child: const Text('Save Draft')),
        ],
      ),
    );
  }


  Widget _interestChip(String label) {
    bool isSelected = _model.selectedInterests.contains(label);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (v) => setState(() {
          if (v) _model.selectedInterests.add(label);
          else _model.selectedInterests.remove(label);
        }),
      ),
    );
  }
}