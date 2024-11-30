import 'package:flutter/material.dart';
import 'admin/admin_login.dart';
import 'user/user_login.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginScreen()),
                );
              },
              child: Text('Login as Admin'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserLoginScreen()),
                );
              },
              child: Text('Login as User'),
            ),
          ],
        ),
      ),
    );
  }
}
