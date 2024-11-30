import 'package:flutter/material.dart';
import 'admin_workout_diet_plan.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // التوجيه إلى صفحة خطط التمرين والنظام الغذائي
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminWorkoutDietPlan()),
            );
          },
          child: Text('Go to Workout & Diet Plan'),
        ),
      ),
    );
  }
}
