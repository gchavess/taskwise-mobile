import 'package:flutter/material.dart';
import 'package:task_wise_frontend/constants/colors.dart';

class Task {
  IconData? iconData;
  String? title;
  Color? iconColor;
  Color? bgColor;
  Color? btnColor;
  num? left;
  num? done;
  List<Map<String, dynamic>>? desc;
  bool isLast;
  Task(
      {this.iconData,
      this.title,
      this.iconColor,
      this.bgColor,
      this.btnColor,
      this.left,
      this.done,
      this.desc,
      this.isLast = false});
  static List<Task> generateTasks() {
    return [
      Task(
          iconData: Icons.person_rounded,
          title: 'Pessoal',
          bgColor: kYellowLight,
          iconColor: kYellowDark,
          btnColor: kYellow,
          left: 3,
          done: 1,
          desc: [
            {
              'time': '9:00',
              'title': 'Passear com o cachorro',
              'slot': '9:00 - 10:00',
              'tlColor': kRedDark,
            }
          ]),
      Task(
          iconData: Icons.cases_rounded,
          title: 'Trabalho',
          bgColor: kRedLight,
          iconColor: kRedDark,
          btnColor: kRed,
          left: 0,
          done: 0),
      Task(
          iconData: Icons.favorite_rounded,
          title: 'Saúde',
          bgColor: kBlueLight,
          iconColor: kBlueDark,
          btnColor: kBlue,
          left: 0,
          done: 0),
      Task(
          iconData: Icons.person_rounded,
          title: 'Pessoal',
          bgColor: kYellowLight,
          iconColor: kYellowDark,
          btnColor: kYellow,
          left: 3,
          done: 1),
      Task(
          iconData: Icons.cases_rounded,
          title: 'Trabalho',
          bgColor: kRedLight,
          iconColor: kRedDark,
          btnColor: kRed,
          left: 0,
          done: 0),
      Task(
          iconData: Icons.favorite_rounded,
          title: 'Saúde',
          bgColor: kBlueLight,
          iconColor: kBlueDark,
          btnColor: kBlue,
          left: 0,
          done: 0),
      Task(isLast: true),
    ];
  }
}
