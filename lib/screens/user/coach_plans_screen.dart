import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoachPlansScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coach\'s Workout Plans'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('users') // استعلام من مجموعة المستخدمين
              .doc('sobhy') // المستند الخاص بالمستخدم 'sobhy'
              .collection('workout_plans') // مجموعة خطط التمرين للمستخدم
              .snapshots(), // جلب البيانات في الوقت الفعلي
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error loading workout plans'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No workout plans available.'));
            }

            final plans = snapshot.data!.docs;

            return ListView.builder(
              itemCount: plans.length,
              itemBuilder: (context, index) {
                var plan = plans[index].data() as Map<String, dynamic>;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      plan['plan_name'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(plan['details']),
                    onTap: () {
                      // يمكنك إضافة منطق لعرض تفاصيل الخطة أو تنفيذ إجراءات أخرى.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected: ${plan['plan_name']}')),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
