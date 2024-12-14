import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProgressMonitoring extends StatefulWidget {
  @override
  _ProgressMonitoringState createState() => _ProgressMonitoringState();
}

class _ProgressMonitoringState extends State<ProgressMonitoring> {
  double _progress = 0.5;  // قيمة التقدم (من 0 إلى 1)
  String _progressText = "50% Completed";
  String _workoutType = "Running";  // نوع التمرين (يمكن تغييره حسب المدخلات)

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // دالة لتحديث التقدم بناءً على التمرين
  void _updateProgress() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // إضافة التقدم إلى Firestore
      await _firestore.collection('progress_reports').add({
        'userId': user.uid,
        'workoutType': _workoutType,  // إضافة نوع التمرين
        'progress': _progress,
        'progressText': _progressText,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // تحديث التقدم في الواجهة
      setState(() {
        _progress = (_progress + 0.1) % 1.1;
        _progressText = "${(_progress * 100).toInt()}% Completed";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user logged in!')),
      );
    }
  }

  // دالة لعرض التقدمات المحفوظة من Firestore
  Stream<List<Map<String, dynamic>>> _getProgressReports() {
    return _firestore
        .collection('progress_reports')
        .where('workoutType', isEqualTo: _workoutType) // فلترة التقدمات بناءً على نوع التمرين
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Monitoring - $_workoutType'),
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
              'Track Your $_workoutType Progress',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              minHeight: 10,
            ),
            SizedBox(height: 20),
            Text(
              _progressText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 40),
            // تغيير التمرين بناءً على اختيار المستخدم (اختياري)
            DropdownButton<String>(
              value: _workoutType,
              items: ['Running', 'Cycling', 'Swimming']
                  .map((workout) => DropdownMenuItem<String>(
                value: workout,
                child: Text(workout),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _workoutType = value!;
                  _progress = 0.0;  // إعادة التعيين عند تغيير التمرين
                  _progressText = "0% Completed";
                });
              },
            ),
            SizedBox(height: 40),
            // عرض التقرير من Firestore
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _getProgressReports(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong!'));
                  }

                  var progressReports = snapshot.data ?? [];

                  return ListView.builder(
                    itemCount: progressReports.length,
                    itemBuilder: (context, index) {
                      var progress = progressReports[index];
                      var timestamp = (progress['timestamp'] as Timestamp)
                          .toDate()
                          .toString();
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          title: Text(
                            '${(progress['progress'] * 100).toInt()}% Completed',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                          subtitle: Text('Updated at: $timestamp'),
                        ),
                      );
                    },
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
