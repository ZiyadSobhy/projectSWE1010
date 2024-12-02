import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _gender = "Male";

  void _saveProfile() {
    // هنا يمكننا حفظ البيانات محليًا أو إرسالها إلى قاعدة بيانات
    print('Profile Saved');
    print('Name: ${_nameController.text}');
    print('Age: ${_ageController.text}');
    print('Weight: ${_weightController.text}');
    print('Height: ${_heightController.text}');
    print('Gender: $_gender');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Profile'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),

            // Name field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),

            // Age field
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.calendar_today, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),

            // Weight field
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.monitor_weight, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),

            // Height field
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.height, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),

            // Gender dropdown
            DropdownButtonFormField<String>(
              value: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value!;
                });
              },
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Gender',
                labelStyle: TextStyle(color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                prefixIcon: Icon(Icons.transgender, color: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 30),

            // Save Button
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text(
                'Save Profile',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blueAccent, // Corrected parameter
                foregroundColor: Colors.white, // Corrected to foregroundColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
