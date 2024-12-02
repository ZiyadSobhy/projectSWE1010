import 'package:flutter/material.dart';

class ProgressMonitoring extends StatefulWidget {
  @override
  _ProgressMonitoringState createState() => _ProgressMonitoringState();
}

class _ProgressMonitoringState extends State<ProgressMonitoring> {
  double _progress = 0.5;  // قيمة التقدم (من 0 إلى 1)
  String _progressText = "50% Completed";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Monitoring'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Track Your Progress',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress,  // يحدد مستوى التقدم
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              minHeight: 10,
            ),
            SizedBox(height: 20),
            Text(
              _progressText,  // نص التقدم
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // لتحديث التقدم بشكل عشوائي للمثال
                  _progress = (_progress + 0.1) % 1.1;
                  _progressText = "${(_progress * 100).toInt()}% Completed";
                });
              },
              child: Text('Update Progress'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
