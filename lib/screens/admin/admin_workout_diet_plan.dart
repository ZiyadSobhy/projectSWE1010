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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Add a new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? Center(
                child: Text(
                  'No tasks added yet!',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_tasks[index]),
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
