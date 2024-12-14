import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _gender = "Male";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    // الحصول على المستخدم الحالي
    _user = _auth.currentUser;
    if (_user != null) {
      _loadUserProfile();
    }
  }

  void _loadUserProfile() async {
    // تحميل بيانات المستخدم من Firestore إذا كانت موجودة
    DocumentSnapshot doc = await _firestore.collection('users').doc(_user!.uid).get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      _nameController.text = data['name'] ?? '';
      _ageController.text = data['age'] ?? '';
      _weightController.text = data['weight'] ?? '';
      _heightController.text = data['height'] ?? '';
      _gender = data['gender'] ?? 'Male';
      setState(() {});
    }
  }

  void _saveProfile() async {
    // حفظ بيانات المستخدم في Firestore
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.uid).set({
        'name': _nameController.text,
        'age': _ageController.text,
        'weight': _weightController.text,
        'height': _heightController.text,
        'gender': _gender,
      }, SetOptions(merge: true)); // يستخدم "merge" لكي لا يتم مسح البيانات القديمة

      // عرض رسالة بعد حفظ البيانات
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile Saved'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Profile'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Name field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),

            // Age field
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.calendar_today, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),

            // Weight field
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.monitor_weight, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),

            // Height field
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.height, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),

            // Gender dropdown
            DropdownButtonFormField<String>(
              value: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value!;
                });
              },
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Gender',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.transgender, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 30),

            // Save Button
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text(
                'Save Profile',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
