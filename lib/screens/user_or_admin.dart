import 'package:flutter/material.dart';
import 'admin/admin_login.dart';
import 'user/user_login.dart';

class UserOrAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Please select your role'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // التوجيه إلى صفحة تسجيل الدخول للمستخدم
                Navigator.pushNamed(context, '/user/login');
              },
              child: Text('I am a User'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // التوجيه إلى صفحة تسجيل الدخول للإداري
                Navigator.pushNamed(context, '/admin/login');
              },
              child: Text('I am an Admin'),
            ),
          ],
        ),
      ),
    );
  }
}
