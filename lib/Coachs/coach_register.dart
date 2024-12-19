import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // لإضافة Firebase Firestore
import 'coach_dashboard_screen.dart';  // تأكد من استيراد شاشة لوحة تحكم المدرب

class CoachRegisterScreen extends StatefulWidget {
  @override
  _CoachRegisterScreenState createState() => _CoachRegisterScreenState();
}

class _CoachRegisterScreenState extends State<CoachRegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();  // حقل الاسم
  final _codeController = TextEditingController();  // حقل الكود

  // تسجيل المدرب عبر البريد الإلكتروني وكلمة المرور والاسم والكود
  Future<void> _registerWithEmailPassword() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String name = _nameController.text.trim();
    String code = _codeController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty && code.isNotEmpty) {
      try {
        // التحقق من صحة الكود واسم المدرب في مجموعة coaches
        QuerySnapshot coachData = await FirebaseFirestore.instance
            .collection('coaches')
            .where('name', isEqualTo: name)
            .where('code', isEqualTo: code)
            .get();

        if (coachData.docs.isNotEmpty) {
          // إذا تم العثور على المدرب والكود في مجموعة coaches
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          // إضافة بيانات المدرب إلى مجموعة المستخدمين بعد التسجيل
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
              'name': name,
              'email': email,
              'coachCode': code,  // إضافة الكود في بيانات المستخدم
            });
          }

          // الانتقال إلى شاشة لوحة تحكم المدرب
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CoachDashboardScreen()),
          );
        } else {
          // إذا لم يتم العثور على المدرب والكود
          _showErrorDialog('Invalid name or code');
        }
      } on FirebaseAuthException catch (e) {
        _showErrorDialog(e.message ?? 'Registration failed');
      }
    } else {
      _showErrorDialog('Please fill in all fields');
    }
  }

  // عرض رسائل الخطأ
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coach Register'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // حقل الاسم
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // حقل البريد الإلكتروني
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // حقل كلمة المرور
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // حقل الكود
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Enter your code',
                  prefixIcon: Icon(Icons.code),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // زر التسجيل
              ElevatedButton(
                onPressed: _registerWithEmailPassword,
                child: Text('Register', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
