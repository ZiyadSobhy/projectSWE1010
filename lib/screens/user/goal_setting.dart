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
        backgroundColor: Colors.blueAccent, // Use backgroundColor instead of primary
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Set your fitness goals:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            _buildGoalTextField(
              _caloriesController,
              'Calories Burned',
              Icons.local_fire_department,
            ),
            SizedBox(height: 20),
            _buildGoalTextField(
              _durationController,
              'Workout Duration (minutes)',
              Icons.timer,
              TextInputType.number,
            ),
            SizedBox(height: 20),
            _buildGoalTextField(
              _stepsController,
              'Number of Steps',
              Icons.directions_walk,
              TextInputType.number,
            ),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _saveGoals,
                child: Text('Save Goals'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Use backgroundColor here
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalTextField(
      TextEditingController controller, String label, IconData icon,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
