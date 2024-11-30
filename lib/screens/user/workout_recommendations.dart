import 'package:flutter/material.dart';

class WorkoutRecommendations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Recommendations')),
      body: Center(
        child: Text('Get personalized workout recommendations.'),
      ),
    );
  }
}
