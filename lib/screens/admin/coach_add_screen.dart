import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoachAddScreen extends StatefulWidget {
  @override
  _CoachAddScreenState createState() => _CoachAddScreenState();
}

class _CoachAddScreenState extends State<CoachAddScreen> {
  final _coachNameController = TextEditingController();
  final _coachEmailController = TextEditingController();
  final _coachCodeController = TextEditingController();
  final _coachUserNameController = TextEditingController();

  Future<void> _addCoach() async {
    String name = _coachNameController.text.trim();
    String email = _coachEmailController.text.trim();
    String code = _coachCodeController.text.trim();
    String userName = _coachUserNameController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && code.isNotEmpty && userName.isNotEmpty) {
      try {
        // إضافة المدرب إلى Firestore
        await FirebaseFirestore.instance.collection('coaches').add({
          'name': name,
          'email': email,
          'code': code,
          'userName': userName,
          'createdAt': FieldValue.serverTimestamp(), // نضيف التاريخ بشكل تلقائي من Firestore
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Coach Added Successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        // يمكن إضافة توجيه إلى شاشة أخرى إذا لزم الأمر
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SomeOtherScreen()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add coach. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Coach'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // حقل اسم المدرب
            TextField(
              controller: _coachNameController,
              decoration: InputDecoration(
                labelText: 'Coach Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            // حقل البريد الإلكتروني
            TextField(
              controller: _coachEmailController,
              decoration: InputDecoration(
                labelText: 'Coach Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            // حقل الكود
            TextField(
              controller: _coachCodeController,
              decoration: InputDecoration(
                labelText: 'Coach Code',
                prefixIcon: Icon(Icons.security),
              ),
            ),
            SizedBox(height: 20),
            // حقل اسم المستخدم
            TextField(
              controller: _coachUserNameController,
              decoration: InputDecoration(
                labelText: 'Coach Username',
                prefixIcon: Icon(Icons.account_circle),
              ),
            ),
            SizedBox(height: 30),
            // زر إضافة المدرب
            ElevatedButton(
              onPressed: _addCoach,
              child: Text('Add Coach'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.teal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
