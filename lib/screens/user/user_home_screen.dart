import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_profile_screen.dart';
import 'user_activity_tracking_screen.dart';
import 'progress_monitoring.dart';
import 'goal_setting.dart';
import 'coach_plans_screen.dart'; // Add the new screen here

class UserHomeScreen extends StatelessWidget {
  final String email;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserHomeScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $email'),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              context,
              Icons.person,
              'Profile Management',
              'Edit your profile and set your fitness goals.',
                  () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(),
                ),
              ),
            ),
            _buildCard(
              context,
              Icons.directions_run,
              'Activity Tracking',
              'Log your fitness activities.',
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActivityTrackingScreen()),
              ),
            ),
            _buildCard(
              context,
              Icons.bar_chart,
              'Progress Monitoring',
              'View your progress over time.',
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgressMonitoring()),
              ),
            ),
            _buildCard(
              context,
              Icons.flag,
              'Goal Setting',
              'Set and track your fitness goals.',
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GoalSetting()),
              ),
            ),
            // New section for Coach's workout plans
            _buildCard(
              context,
              Icons.assignment_turned_in,
              'Coach\'s Workout Plans',
              'View and manage the workout plans created by your coach.',
                  () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoachPlansScreen()), // Navigate to CoachPlansScreen
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        leading: Icon(
          icon,
          size: 32.0,
          color: Colors.blueAccent,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.0,
          ),
        ),
        onTap: onTap,
        tileColor: Colors.white,
      ),
    );
  }
}
