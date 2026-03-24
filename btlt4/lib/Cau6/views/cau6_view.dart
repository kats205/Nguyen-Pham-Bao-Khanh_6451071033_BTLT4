import 'package:flutter/material.dart';
import '../models/cau6_model.dart';
import '../widget/cau6_widget.dart';

class Cau6View extends StatefulWidget {
  const Cau6View({super.key});

  @override
  State<Cau6View> createState() => _Cau6ViewState();
}

class _Cau6ViewState extends State<Cau6View> {
  final _model = Cau6Model();
  bool _obscurePassword = true;
  bool _obscureConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Đăng ký Tài khoản Nâng cao'),
        backgroundColor: const Color(0xFF1B4042),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.account_circle, size: 80, color: Color(0xFF1B4042)),
            const Text('Đăng ký Tài khoản', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            
            _buildField('Họ tên', Icons.person, (v) => _model.fullName = v, (v) => v!.isEmpty ? 'Vui lòng nhập họ tên' : null),
            _buildField('Email', Icons.email, (v) => _model.email = v, (v) {
              if (v!.isEmpty) return 'Vui lòng nhập email';
              if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v)) return 'Email không hợp lệ';
              return null;
            }),
            
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              onChanged: (v) => setState(() => _model.password = v),
            ),
            if (_model.password.isNotEmpty)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(_model.passwordStrength, 
                    style: TextStyle(color: _model.passwordStrength.contains('Mạnh') ? Colors.green : Colors.blue)),
                ),
              ),
            
            const SizedBox(height: 16),
            TextField(
              obscureText: _obscureConfirmPass,
              decoration: InputDecoration(
                labelText: 'Xác nhận mật khẩu',
                errorText: (_model.confirmPassword.isNotEmpty && !_model.isPasswordMatch) ? 'Mật khẩu xác nhận chưa khớp' : null,
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPass ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureConfirmPass = !_obscureConfirmPass),
                ),
              ),
              onChanged: (v) => setState(() => _model.confirmPassword = v),
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _model.isValid ? () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đăng ký nâng cao thành công!')));
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF608284),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Đăng ký'),
              ),
            ),
            const SizedBox(height: 32),
            const Center(child: StudentInfoWidget()),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, IconData icon, Function(String) onChanged, String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon, size: 20)),
        onChanged: (v) => setState(() => onChanged(v)),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}