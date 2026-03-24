import 'package:flutter/material.dart';
import '../models/cau1_model.dart';
import '../widget/cau1_widget.dart';

class Cau1View extends StatefulWidget {
  const Cau1View({super.key});

  @override
  State<Cau1View> createState() => _Cau1ViewState();
}

class _Cau1ViewState extends State<Cau1View> {
  final _formKey = GlobalKey<FormState>();
  final _model = Cau1Model();
  bool _obscurePassword = true;

  void _onFormChanged() {
    setState(() {
      // Re-evaluate submit button state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng Ký Tài Khoản'),
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          onChanged: _onFormChanged,
          child: Column(
            children: [
              const Icon(Icons.account_circle, size: 80, color: Color(0xFF1B4042)),
              const Text('Account Circle', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Họ và tên',
                  hintText: 'Nguyen Van A',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (v) => _model.fullName = v,
                validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập họ và tên' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@domain.com',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.check, color: Colors.green),
                ),
                onChanged: (v) => _model.email = v,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email không được để trống';
                  if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v)) {
                    return 'Email không hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                onChanged: (v) => _model.password = v,
                validator: (v) => (v == null || v.isEmpty) ? 'Vui lòng nhập mật khẩu' : null,
              ),
              const SizedBox(height: 16),
              
              CheckboxListTile(
                title: const Text('Tôi đồng ý với các Điều khoản & Chính sách'),
                value: _model.agreeToTerms,
                onChanged: (v) => setState(() => _model.agreeToTerms = v ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _model.agreeToTerms) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đăng ký thành công!')),
                      );
                    } else {
                      if (!_model.agreeToTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Bạn chưa đồng ý với điều khoản!')),
                        );
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đăng ký không thành công. Vui lòng kiểm tra lại thông tin!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2A96D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text('Đăng Ký', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 32),
              const StudentInfoWidget(), // MSSV component
            ],
          ),
        ),
      ),
    );
  }
}