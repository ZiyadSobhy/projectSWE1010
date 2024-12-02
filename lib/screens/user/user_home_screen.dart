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
        backgroundColor: Colors.blueAccent, // اختيار اللون المناسب
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
                MaterialPageRoute(builder: (context) => ProfileScreen()),
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
          ],
        ),
      ),
    );
  }

  // دالة لبناء كل بطاقة بشكل موحد
  Widget _buildCard(BuildContext context, IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // إضافة حواف دائرية للبطاقة
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        leading: Icon(
          icon,
          size: 32.0,
          color: Colors.blueAccent, // تغيير لون الأيقونة
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
        tileColor: Colors.white, // تغيير خلفية العنصر عند المرور عليه
      ),
    );
  }
}
