import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CoachAddScreen extends StatefulWidget {
  @override
  _CoachAddScreenState createState() => _CoachAddScreenState();
}

class _CoachAddScreenState extends State<CoachAddScreen> {
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController(); // لإدخال اسم المستخدم
  List<String> _userNames = [];  // قائمة أسماء المستخدمين
  List<String> _filteredUserNames = [];  // قائمة الأسماء المرشحة بناءً على الكتابة
  bool _isLoading = false;  // لتحديد ما إذا كان يتم تحميل البيانات من Firebase

  // دالة لتحميل أسماء المستخدمين من Firebase
  Future<void> _loadUserNames(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)  // فلترة الأسماء بناءً على الإدخال
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')  // إضافة نهاية محرف لتحديد النطاق
          .get();

      List<String> names = querySnapshot.docs
          .map((doc) => doc['name'] as String)
          .toList();

      setState(() {
        _filteredUserNames = names;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading user names: $e');
    }
  }

  // دالة لإضافة المدرب
  Future<void> _addCoach() async {
    String code = _codeController.text.trim();
    String name = _nameController.text.trim();
    String userName = _userNameController.text.trim(); // الحصول على اسم المستخدم

    if (code.isNotEmpty && name.isNotEmpty && userName.isNotEmpty) {
      try {
        // البحث عن المستخدم في مجموعة users باستخدام الاسم
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('name', isEqualTo: userName)  // البحث باستخدام اسم المستخدم
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          // إذا تم العثور على المستخدم
          // إضافة المدرب إلى مجموعة coaches
          await FirebaseFirestore.instance.collection('coaches').add({
            'code': code,
            'name': name,
            'userName': userName,  // إضافة اسم المستخدم مع المدرب
            'createdAt': Timestamp.now(),
          });

          // عرض رسالة نجاح
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text('Coach added successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);  // العودة إلى الشاشة السابقة
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // إذا لم يتم العثور على المستخدم باستخدام الاسم
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text('User with name "$userName" not found'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        // عرض رسالة خطأ في حالة فشل العملية
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add coach: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      // إذا كانت الحقول فارغة
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Coach'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            Text(
              'Add a New Coach',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // حقل كود المدرب
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Coach Code',
                prefixIcon: Icon(Icons.code),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // حقل اسم المدرب
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Coach Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // حقل اسم المستخدم مع القائمة المنسدلة
            TextField(
              controller: _userNameController,
              onChanged: _loadUserNames,  // تحميل الأسماء عند الكتابة
              decoration: InputDecoration(
                labelText: 'User Name',
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // إظهار القائمة المنسدلة عندما تتوفر الأسماء
            _filteredUserNames.isNotEmpty
                ? Column(
              children: _filteredUserNames.map((userName) {
                return ListTile(
                  title: Text(userName),
                  onTap: () {
                    _userNameController.text = userName;
                    setState(() {
                      _filteredUserNames = [];  // إخفاء القائمة بعد الاختيار
                    });
                  },
                );
              }).toList(),
            )
                : _isLoading
                ? CircularProgressIndicator()  // عرض التحميل
                : Container(),
            SizedBox(height: 20),
            // زر إضافة المدرب
            ElevatedButton(
              onPressed: _addCoach,
              child: Text('Add Coach', style: TextStyle(fontSize: 18)),
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
