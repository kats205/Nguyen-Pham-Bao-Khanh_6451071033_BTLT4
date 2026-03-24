import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../models/cau10_model.dart';
import '../widget/cau10_widget.dart';

class Cau10View extends StatefulWidget {
  const Cau10View({super.key});

  @override
  State<Cau10View> createState() => _Cau10ViewState();
}

class _Cau10ViewState extends State<Cau10View> {
  final _model = Cau10Model();
  final _formKey = GlobalKey<FormState>();
  
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() && _model.isValid) {
      setState(() => _model.isSubmitting = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _model.isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Form submitted successfully! (mock)')));
    }
  }

  void _reset() {
    _formKey.currentState!.reset();
    setState(() {
      _model.fullName = "";
      _model.email = "";
      _model.phone = "";
      _model.dob = null;
      _model.cvFileName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Form'),
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                focusNode: _nameFocus,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(), suffix: Icon(Icons.check, color: Colors.green, size: 16)),
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập tên' : null,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocus),
                onChanged: (v) => _model.fullName = v,
              ),
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
                      validator: (v) => (!v!.contains('@')) ? 'Invalid email format' : null,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_phoneFocus),
                      onChanged: (v) => _model.email = v,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      focusNode: _phoneFocus,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                      validator: (v) => (v!.length < 10) ? 'Required field' : null,
                      onChanged: (v) => _model.phone = v,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              const Text('Preferred Communication Channels:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Row(
                children: [
                  _commCheckbox('Email', _model.email.isNotEmpty, (v) {}),
                  _commCheckbox('Phone', _model.phone.isNotEmpty, (v) {}),
                  _commCheckbox('SMS', false, (v) {}),
                ],
              ),
              
              const Text('Gender', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Row(
                children: [
                  _genderRadio('Male'),
                  _genderRadio('Female'),
                  _genderRadio('Other'),
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _model.country,
                      decoration: const InputDecoration(labelText: 'Country', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                      items: ['Vietnam', 'USA', 'Japan'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12)))).toList(),
                      onChanged: (v) => setState(() => _model.country = v!),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Experience (${_model.experience.toInt()} Years)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        Slider(value: _model.experience, max: 10, onChanged: (v) => setState(() => _model.experience = v)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                   Expanded(
                    child: InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());
                        if (picked != null) setState(() => _model.dob = picked);
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: 'Date of Birth', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                        child: Text(_model.dob == null ? 'Select Date' : DateFormat('dd/MM/yyyy').format(_model.dob!), style: const TextStyle(fontSize: 12)),
                      ),
                    ),
                   ),
                   const SizedBox(width: 8),
                   Expanded(
                    child: InkWell(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();
                        if (result != null) setState(() => _model.cvFileName = result.files.single.name);
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: 'Upload CV', border: OutlineInputBorder(), suffixIcon: Icon(Icons.cloud_upload, size: 20), contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                        child: Text(_model.cvFileName ?? 'No file', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                      ),
                    ),
                   ),
                ],
              ),
              const SizedBox(height: 20),
              
              const Text('Skills:', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  _skillCheckbox('Python', _model.isPython, (v) => setState(() => _model.isPython = v!)),
                  _skillCheckbox('Dart', _model.isDart, (v) => setState(() => _model.isDart = v!)),
                  _skillCheckbox('Projects', _model.isProjectManagement, (v) => setState(() => _model.isProjectManagement = v!)),
                ],
              ),
              
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: _reset, style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]), child: const Text('Reset Form'))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _model.isSubmitting ? null : _submit,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B4042), foregroundColor: Colors.white),
                      child: _model.isSubmitting 
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                        : const Text('Submit'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const Center(child: StudentInfoWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _commCheckbox(String label, bool value, Function(bool?)? onChanged) {
    return Row(children: [Checkbox(value: value, onChanged: null), Text(label, style: const TextStyle(fontSize: 10))]);
  }

  Widget _skillCheckbox(String label, bool value, Function(bool?)? onChanged) {
    return Row(children: [Checkbox(value: value, onChanged: onChanged), Text(label, style: const TextStyle(fontSize: 10))]);
  }

  Widget _genderRadio(String label) {
    return Row(children: [Radio(value: label, groupValue: _model.gender, onChanged: (v) => setState(() => _model.gender = v.toString())), Text(label, style: const TextStyle(fontSize: 10))]);
  }
}