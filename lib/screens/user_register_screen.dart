import 'package:flutter/material.dart';

class UserRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register as User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('User Registration Page'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user/dashboard');
              },
              child: Text('Go to User Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
