import 'package:flutter/material.dart';

class ActivityTrackingScreen extends StatefulWidget {
  @override
  _ActivityTrackingScreenState createState() => _ActivityTrackingScreenState();
}

class _ActivityTrackingScreenState extends State<ActivityTrackingScreen> {
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  final List<Map<String, String>> _activities = [];

  void _addActivity() {
    setState(() {
      _activities.add({
        'activity': _activityController.text,
        'duration': _durationController.text,
        'calories': _caloriesController.text,
      });
      _activityController.clear();
      _durationController.clear();
      _caloriesController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Activities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _activityController,
              decoration: InputDecoration(labelText: 'Activity'),
            ),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Duration (minutes)'),
            ),
            TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Calories Burned'),
            ),
            ElevatedButton(
              onPressed: _addActivity,
              child: Text('Add Activity'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _activities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_activities[index]['activity']!),
                    subtitle: Text(
                        'Duration: ${_activities[index]['duration']} minutes\nCalories: ${_activities[index]['calories']} kcal'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
