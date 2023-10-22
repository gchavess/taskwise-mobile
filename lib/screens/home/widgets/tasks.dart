import 'package:flutter/material.dart';
import 'package:task_wise_frontend/models/task.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:task_wise_frontend/screens/detail/detail.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: Task.generateTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while data is being fetched.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final tasksList = snapshot.data;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              itemCount: tasksList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) => tasksList[index].isLast
                  ? _buildAddTask()
                  : _buildTask(context, tasksList[index]),
            ),
          ); // Remove the extra semicolon here
        }
      },
    );
  }

  Widget _buildAddTask() {
    return DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: const [10, 10],
        color: Colors.grey,
        strokeWidth: 2,
        child: const Center(
          child: Text(
            '+ Adicionar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget _buildTask(BuildContext context, Task task) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DetailPage(task)));
      },
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: task.bgColor, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(task.iconData, color: task.iconColor, size: 35),
              const SizedBox(height: 30),
              Text(
                task.title!,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildTaskStatus(task.btnColor!, task.iconColor!,
                      '${task.left} restantes'),
                  const SizedBox(width: 2),
                  _buildTaskStatus(
                      Colors.white, task.iconColor!, '${task.done} feitas')
                ],
              )
            ],
          )),
    );
  }

  Widget _buildTaskStatus(Color bgColor, Color txColor, String text) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.8, vertical: 10),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(20)),
        child: Text(text, style: TextStyle(color: txColor)));
  }
}
