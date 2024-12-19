import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateWorkoutPlansScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController(); // إضافة حقل اسم المستخدم

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Workout Plan'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // حقل إدخال اسم المستخدم
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'Enter User Name'), // حقل إدخال اسم المستخدم
            ),
            // حقل إدخال اسم الخطة
            TextField(
              controller: _planNameController,
              decoration: InputDecoration(labelText: 'Plan Name'),
            ),
            // حقل إدخال التفاصيل
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _createWorkoutPlan(context); // تم تمرير context هنا
              },
              child: Text('Create Plan'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create a workout plan and send it to a specific user
  void _createWorkoutPlan(BuildContext context) {
    final planName = _planNameController.text;
    final details = _detailsController.text;
    final userName = _userNameController.text.trim(); // الحصول على اسم المستخدم المدخل

    // تحقق من أن جميع الحقول مليئة
    if (planName.isNotEmpty && details.isNotEmpty && userName.isNotEmpty) {
      // إضافة الخطة إلى Firestore تحت مستند المستخدم
      _firestore
          .collection('users') // مجموعة المستخدمين
          .doc(userName) // مستند المستخدم باستخدام الاسم المدخل
          .collection('workout_plans') // مجموعة خطط التمرين للمستخدم
          .add({
        'plan_name': planName,
        'details': details,
        'created_at': Timestamp.now(),
      }).then((_) {
        // مسح الحقول بعد إضافة الخطة
        _planNameController.clear();
        _detailsController.clear();
        _userNameController.clear(); // مسح حقل اسم المستخدم بعد الإرسال

        // إظهار رسالة نجاح
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Workout plan sent to $userName successfully!')));
      }).catchError((error) {
        // التعامل مع الأخطاء
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: Could not add the plan. $error')));
      });
    } else {
      // إظهار رسالة خطأ إذا كانت الحقول فارغة
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill out all fields')));
    }
  }
}
