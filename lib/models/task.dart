import 'package:flutter/material.dart';
import 'package:task_wise_frontend/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Task {
  IconData? iconData;
  String? title;
  Color? iconColor;
  Color? bgColor;
  Color? btnColor;
  int? left;
  int? done;
  List<Map<String, dynamic>>? desc;
  bool isLast;

  Task({
    this.iconData,
    this.title,
    this.iconColor,
    this.bgColor,
    this.btnColor,
    this.left,
    this.done,
    this.desc,
    this.isLast = false,
  });

  static Future<List<Task>> generateTasks() async {
    final response = await http
        .get(Uri.parse('https://taskwise-backend.cyclic.cloud/goals'));

    final data = json.decode(response.body);

    List<Task> goals = (data as List).map((goalData) {
      List<Map<String, dynamic>> taskData =
          (goalData['tasks'] as List).map((task) {
        return {
          'title': task['titulo'] ?? "N/A",
          'time': task['hora_inicio'],
          'slot': '${task['hora_inicio']} - ${task['hora_fim']}',
          'tlColor': kRedDark,
          'bgColor': kRedLight,
        };
      }).toList();

      return Task(
        iconData: Icons.cases_rounded,
        title: goalData['titulo'],
        bgColor: kRedLight,
        iconColor: kRedDark,
        btnColor: kRed,
        left: goalData['progresso'],
        done: goalData['concluido'] ? 1 : 0,
        desc: taskData,
      );
    }).toList();

    goals.add(Task(isLast: true));

    return goals;
  }
}
