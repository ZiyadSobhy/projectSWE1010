import 'package:flutter/material.dart';

class AdminWorkoutDietPlan extends StatefulWidget {
  @override
  _AdminWorkoutDietPlanState createState() => _AdminWorkoutDietPlanState();
}

class _AdminWorkoutDietPlanState extends State<AdminWorkoutDietPlan> {
  final TextEditingController _taskController = TextEditingController();
  final List<String> _tasks = []; // قائمة لحفظ المهام

  void _addTask() {
    String task = _taskController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add(task); // إضافة المهمة إلى القائمة
        _taskController.clear(); // تنظيف حقل الإدخال بعد الإضافة
      });
    } else {
      // عرض رسالة تنبيه إذا كان الحقل فارغًا
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a task')),
      );
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index); // حذف المهمة من القائمة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout & Diet Plans'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create and Manage Plans',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Add tasks to organize your plans effectively.',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter a task',
                      hintText: 'e.g., Morning Workout',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: _addTask,
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_alt_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'No tasks added yet!',
                      style:
                      TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        _tasks[index],
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
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
