import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoachesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Coaches'),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // استرجاع البيانات من Firestore Collection "coaches"
        stream: FirebaseFirestore.instance.collection('coaches').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No coaches available'));
          }

          // استرجاع المدربين من البيانات المسترجعة من Firestore
          List<Map<String, dynamic>> coaches = snapshot.data!.docs.map((doc) {
            // تحويل المستند إلى Map للتحقق من الحقول
            var data = doc.data() as Map<String, dynamic>;
            return {
              'name': data['name'] ?? 'Unknown',
              'userName': data.containsKey('userName') ? data['userName'] : 'No Username',
              'code': data['code'] ?? 'No Code',
              'createdAt': (data['createdAt'] as Timestamp).toDate().toString(),
            };
          }).toList();

          return ListView.builder(
            itemCount: coaches.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: ListTile(
                  title: Text(coaches[index]['name']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username: ${coaches[index]['userName']}'),
                      Text('Code: ${coaches[index]['code']}'),
                      Text('Created At: ${coaches[index]['createdAt']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
