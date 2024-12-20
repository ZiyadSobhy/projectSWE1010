import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateWorkoutPlansScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _planNameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _repsController = TextEditingController(); // عدد التكرارات
  String _selectedCategory = "Push"; // الفئة الافتراضية للتمارين

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Workout Plan'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'Enter User Name'),
            ),
            TextField(
              controller: _planNameController,
              decoration: InputDecoration(labelText: 'Plan Name'),
            ),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            TextField(
              controller: _repsController,
              decoration: InputDecoration(labelText: 'Repetitions'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (String? newValue) {
                _selectedCategory = newValue!;
              },
              items: <String>['Push', 'Legs', 'Back', 'Abs']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _createWorkoutPlan(context);
              },
              child: Text('Create Plan'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create a workout plan and send it to a specific user
  void _createWorkoutPlan(BuildContext context) async {
    final planName = _planNameController.text;
    final details = _detailsController.text;
    final userName = _userNameController.text.trim();
    final reps = int.tryParse(_repsController.text) ?? 0;

    if (planName.isNotEmpty &&
        details.isNotEmpty &&
        userName.isNotEmpty &&
        reps > 0) {
      try {
        // Add the workout plan to Firestore
        await _firestore
            .collection('users')
            .doc(userName)
            .collection('workout_plans')
            .add({
          'plan_name': planName,
          'details': details,
          'category': _selectedCategory,
          'reps': reps,
          'created_at': Timestamp.now(),
        });

        // Clear the fields after submission
        _planNameController.clear();
        _detailsController.clear();
        _userNameController.clear();
        _repsController.clear();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Workout plan for $userName has been created!')));
      } catch (error) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: Could not create the plan. $error')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill out all fields')));
    }
  }
}
