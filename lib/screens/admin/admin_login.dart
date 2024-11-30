import 'package:flutter/material.dart';
import 'admin_dashboard.dart';  // استيراد صفحة لوحة تحكم الإدمن
import 'admin_workout_diet_plan.dart';  // استيراد صفحة خطة التمرين والغذاء
import 'admin_register.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // تسجيل دخول الإدمن
    print('Admin Login');
    print('Email: $email');
    print('Password: $password');

    // بعد التحقق من بيانات الدخول، يمكن التوجيه إلى صفحة لوحة تحكم الإدمن
    Navigator.pushNamed(context, '/admin/dashboard');  // التوجيه إلى صفحة لوحة تحكم الإدمن
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
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
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminRegisterScreen()),
                );
              },
              child: Text('Don\'t have an account? Register as Admin'),
            ),
          ],
        ),
      ),
    );
  }
}
