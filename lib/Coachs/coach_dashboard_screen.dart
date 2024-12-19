import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserProfilesListScreen.dart';
import 'UserActivitiesScreen.dart';
import 'PerformanceAnalysisScreen.dart';
import 'CreateWorkoutPlansScreen.dart'; // Import the new screen

class CoachDashboardScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userName = 'specificUserName'; // Replace with the actual user name or pass it dynamically

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coach Dashboard'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page title
            Center(
              child: Text(
                'Welcome, Coach!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 20),
            // مشاهدة أنشطة المستخدمين
            ListTile(
              leading: Icon(Icons.list, color: Colors.green),
              title: Text('View User Activities'),
              subtitle: Text('Monitor user progress and activities in real-time.'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserActivitiesScreen()), // Navigate to UserActivitiesScreen
                );
              },
            ),
            Divider(),
            // Progress dashboards section
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.green),
              title: Text('Progress Dashboards'),
              subtitle: Text('Analyze performance reports to adjust workout plans.'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PerformanceAnalysisScreen()), // Navigate to PerformanceAnalysisScreen
                );
              },
            ),
            Divider(),
            // User profiles section
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.green),
              title: Text('User Profiles'),
              subtitle: Text('View user profiles and fitness goals to provide guidance.'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilesListScreen()), // Navigate to user profiles list
                );
              },
            ),
            Divider(),
            // Create personalized workout plans section
            ListTile(
              leading: Icon(Icons.edit, color: Colors.green),
              title: Text('Create Personalized Workout Plans'),
              subtitle: Text('Design custom workout plans based on user needs.'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateWorkoutPlansScreen()), // Pass user name
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
