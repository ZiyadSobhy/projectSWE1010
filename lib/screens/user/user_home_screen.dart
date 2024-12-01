import 'package:flutter/material.dart';
import 'user_profile_screen.dart'; // استيراد شاشة إدارة الملف الشخصي
import 'user_activity_tracking_screen.dart'; // استيراد شاشة تتبع النشاط
import 'progress_monitoring.dart'; // استيراد شاشة مراقبة التقدم
import 'goal_setting.dart'; // استيراد شاشة تحديد الأهداف

class UserHomeScreen extends StatelessWidget {
  final String email;

  UserHomeScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $email'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Management'),
            subtitle: Text('Edit your profile and set your fitness goals.'),
            onTap: () {
              // التنقل إلى صفحة إدارة الملف الشخصي
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text('Activity Tracking'),
            subtitle: Text('Log your fitness activities.'),
            onTap: () {
              // التنقل إلى صفحة تتبع النشاط
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActivityTrackingScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Progress Monitoring'),
            subtitle: Text('View your progress over time.'),
            onTap: () {
              // التنقل إلى صفحة مراقبة التقدم
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgressMonitoring()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text('Goal Setting'),
            subtitle: Text('Set and track your fitness goals.'),
            onTap: () {
              // التنقل إلى صفحة تحديد الأهداف
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GoalSetting()),
              );
            },
          ),
        ],
      ),
    );
  }
}
