import 'package:flutter/material.dart';
import 'package:task_wise_frontend/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

    List<Task> tasks = (data as List).map((taskData) {
      return Task(
          iconData: Icons.cases_rounded,
          title: taskData['titulo'],
          bgColor: kRedLight, // Defina a cor desejada
          iconColor: kRedDark, // Defina a cor desejada
          btnColor: kRed, // Defina a cor desejada
          left: taskData['progresso'],
          done: taskData['concluido'] ? 1 : 0,
          desc: [
            {
              'time': '9:00 am',
              'title': 'Teste',
              'slot': '9:00 - 10:00 am',
              'tlColor': kRedDark,
              'bgColor': kRedLight,
            },
            {
              'time': '10:00 am',
              'title': 'Teste 02',
              'slot': '10:00 - 12:00 am',
              'tlColor': kBlueDark,
              'bgColor': kBlueLight,
            },
            {
              'time': '12:00 pm',
              'title': 'Teste 03',
              'slot': '1:00 - 2:00 pm',
              'tlColor': Colors.grey.withOpacity(0.3),
              'bgColor': Colors.grey.withOpacity(0.3),
            },
            {
              'time': '1:00 pm',
              'title': '',
              'slot': '',
              'tlColor': kYellowDark,
              'bgColor': kYellowLight,
            },
            {
              'time': '2:00 pm',
              'title': '',
              'slot': '',
              'tlColor': Colors.grey.withOpacity(0.3),
              'bgColor': Colors.grey.withOpacity(0.3),
            },
          ]);
    }).toList();

    tasks.add(Task(isLast: true));

    return tasks;
  }
}
