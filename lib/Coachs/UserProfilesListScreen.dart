import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profiles'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final userData = user.data() as Map<String, dynamic>;

              final name = userData['name'] ?? 'Unknown';
              final email = userData['email'] ?? 'No Email';

              // Ensure that 'goals' field exists and contains the necessary fields
              final goals = userData['goals'] ?? {}; // Assuming 'goals' contains the necessary fields

              final calories = goals['calories'] ?? 'No Calories';
              final duration = goals['duration'] ?? 'No Duration';
              final steps = goals['steps'] ?? 'No Steps';

              return ListTile(
                leading: Icon(Icons.account_circle, color: Colors.green),
                title: Text(name),
                subtitle: Text(
                    'Email: $email\nCalories: $calories\nDuration: $duration\nSteps: $steps'),
                onTap: () async {
                  DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.id).get();
                  if (userSnapshot.exists) {
                    var userDetails = userSnapshot.data() as Map<String, dynamic>;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('User Information'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Name: ${userDetails['name'] ?? 'N/A'}'),
                            Text('Age: ${userDetails['age'] ?? 'N/A'}'),
                            Text('Gender: ${userDetails['gender'] ?? 'N/A'}'),
                            Text('Height: ${userDetails['height'] ?? 'N/A'}'),
                            Text('Weight: ${userDetails['weight'] ?? 'N/A'}'),
                            // Directly show the values from 'goals'
                            Text('Calories Goal: ${goals['calories'] ?? 'N/A'}'),
                            Text('Duration Goal: ${goals['duration'] ?? 'N/A'}'),
                            Text('Steps Goal: ${goals['steps'] ?? 'N/A'}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User details not found.')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
