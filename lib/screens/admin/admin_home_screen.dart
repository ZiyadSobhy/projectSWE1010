import 'package:flutter/material.dart';
import 'coach_add_screen.dart'; // استيراد شاشة إضافة المدرب
import 'coaches_list_screen.dart'; // استيراد شاشة قائمة المدربين

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // الانتقال إلى شاشة إضافة المدرب
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoachAddScreen()),
                );
              },
              child: Text('Add New Coach'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // الانتقال إلى شاشة قائمة المدربين
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CoachesListScreen()),
                );
              },
              child: Text('View All Coaches'),
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
