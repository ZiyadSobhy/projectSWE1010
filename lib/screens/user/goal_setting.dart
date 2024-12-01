import 'package:flutter/material.dart';

class GoalSetting extends StatefulWidget {
  @override
  _GoalSettingState createState() => _GoalSettingState();
}

class _GoalSettingState extends State<GoalSetting> {
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();

  void _saveGoals() {
    String calories = _caloriesController.text;
    String duration = _durationController.text;
    String steps = _stepsController.text;

    if (calories.isNotEmpty && duration.isNotEmpty && steps.isNotEmpty) {
      // حفظ الأهداف (يمكن ربطها بقاعدة بيانات أو تخزين محلي)
      print('Goals Saved:');
      print('Calories: $calories');
      print('Duration: $duration minutes');
      print('Steps: $steps steps');

      // عرض رسالة نجاح
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Goals saved successfully!')),
      );
    } else {
      // عرض رسالة تحذير عند ترك حقول فارغة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Your Goals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set your fitness goals:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Calories Burned',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Workout Duration (minutes)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _stepsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Steps',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _saveGoals,
                child: Text('Save Goals'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
