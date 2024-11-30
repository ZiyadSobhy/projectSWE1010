import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save profile changes
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
