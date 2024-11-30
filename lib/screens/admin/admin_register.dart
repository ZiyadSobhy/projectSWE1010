import 'package:flutter/material.dart';
import 'admin_dashboard.dart';  // تأكد من استيراد شاشة لوحة تحكم الإدمن
import 'admin_workout_diet_plan.dart';  // تأكد من استيراد شاشة خطط التمرين والنظام الغذائي

class AdminRegisterScreen extends StatefulWidget {
  @override
  _AdminRegisterScreenState createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
  final String adminCode = "admin12345"; // الكود الثابت

  void _register() {
    String email = _emailController.text;
    String password = _passwordController.text;
    String code = _codeController.text;

    // التحقق من صحة الكود
    if (code == adminCode) {
      print('Admin registered successfully!');
      print('Email: $email');

      // بعد التحقق من الكود الصحيح، قم بالتوجيه إلى شاشة لوحة تحكم الإدمن
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboard()),  // التوجيه إلى لوحة تحكم الإدمن
      );
    } else {
      print('Invalid admin code.');
      // هنا يمكن أن تضيف تنبيهًا للمستخدم
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid admin code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as Admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Enter Admin Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
