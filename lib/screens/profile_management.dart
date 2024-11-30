import 'package:flutter/material.dart';

class ProfileManagementScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: 'Weight'),
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Height'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // حفظ البيانات
                print("Profile updated");
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
