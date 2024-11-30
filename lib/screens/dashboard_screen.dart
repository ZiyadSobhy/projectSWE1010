import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final bool isAdmin;

  DashboardScreen({required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isAdmin ? 'Admin Dashboard' : 'User Dashboard')),
      body: Center(
        child: Text(
          isAdmin ? 'Welcome Admin!' : 'Welcome User!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
