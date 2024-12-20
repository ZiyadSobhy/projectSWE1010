import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProgressMonitoring extends StatefulWidget {
  @override
  _ProgressMonitoringState createState() => _ProgressMonitoringState();
}

class _ProgressMonitoringState extends State<ProgressMonitoring> {
  double _progress = 0.0; // Initial progress value
  String _workoutType = "Running"; // Default workout type

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to update progress based on the workout
  void _updateProgress() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Add progress to Firestore in /completed_workout_plans
      await _firestore.collection('completed_workout_plans').add({
        'userId': user.uid,
        'workoutType': _workoutType,
        'progress': _progress,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update progress in the UI
      setState(() {
        _progress = (_progress + 0.1) % 1.1;
      });

      // Show confirmation message that progress has been saved
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Your progress has been saved!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user logged in!')),
      );
    }
  }

  // Function to display workout plans from Firestore
  Stream<List<Map<String, dynamic>>> _getWorkoutPlans() {
    return _firestore
        .collection('users')
        .doc('sobhy') // User 'sobhy'
        .collection('workout_plans') // Workout plans collection for the user
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => {
      ...doc.data() as Map<String, dynamic>,
      'id': doc.id, // Add document ID to the data
    })
        .toList());
  }

  // Function to update task completion status in Firestore in /completed_workout_plans
  Future<void> _updateTaskCompletion(String planId, bool isCompleted) async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Update task completion status in Firestore
      await _firestore.collection('users').doc('sobhy').collection('workout_plans').doc(planId).update({
        'isCompleted': isCompleted,
      });

      // Show confirmation message that the task has been saved
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task has been saved!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user logged in!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Plans'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display workout plans from Firestore
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _getWorkoutPlans(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong!'));
                  }

                  var workoutPlans = snapshot.data ?? [];

                  return ListView.builder(
                    itemCount: workoutPlans.length,
                    itemBuilder: (context, index) {
                      var plan = workoutPlans[index];

                      // Ensure fields are not null
                      String planName = plan['plan_name'] ?? 'No plan name'; // Default value
                      String details = plan['details'] ?? 'No details available'; // Default value
                      bool isCompleted = plan['isCompleted'] ?? false;
                      String planId = plan['id'] ?? ''; // Ensure the id exists

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          title: Text(
                            planName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blueAccent,
                            ),
                          ),
                          subtitle: Text(details),
                          trailing: GestureDetector(
                            onTap: () {
                              // Toggle the completion status
                              setState(() {
                                isCompleted = !isCompleted;
                              });
                              _updateTaskCompletion(planId, isCompleted);
                            },
                            child: Icon(
                              isCompleted ? Icons.check_circle : Icons.cancel,
                              color: isCompleted ? Colors.green : Colors.red,
                              size: 30,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _workoutType = planName; // Update workout type on tap
                            });
                          },
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
