import 'package:flutter/material.dart';

class ActivityTracking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity Tracking')),
      body: Center(
        child: Text('Track your fitness activities.'),
      ),
    );
  }
}
