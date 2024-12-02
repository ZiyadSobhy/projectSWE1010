import 'package:flutter/material.dart';

class UserOrAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Role'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // عنوان أعلى الصفحة
            Text(
              'Welcome! Please select your role',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // زر المستخدم
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/user/login');
              },
              icon: Icon(Icons.person, size: 24),
              label: Text(
                'I am a User',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            // زر الإداري
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/admin/login');
              },
              icon: Icon(Icons.admin_panel_settings, size: 24),
              label: Text(
                'I am an Admin',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
