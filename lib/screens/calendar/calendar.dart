import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_wise_frontend/screens/goals/my_goals.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(null),
                            icon: const Icon(Icons.arrow_back_ios),
                            iconSize: 30,
                          ),
                          const Text(
                            'Calendário',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Chaves: Adicionar caminho para a tela de My Goals.
                            },
                            icon: const Icon(Icons.add),
                            iconSize: 35,
                          ),
                        ],
                      ),
                      buildCalendarRectangle(),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Hoje',
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color.fromARGB(255, 45, 45, 45))),
                        ),
                      ),
                      buildTasksRectangle('Tarefa 01'),
                      const SizedBox(height: 1),
                      buildTasksRectangle('Tarefa 02')
                    ]))
          ],
        ),
      ]),
    );
  }

  Widget buildCalendarRectangle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.only(top: 25, bottom: 30),
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 12),
        child: buildCalendar(),
      ),
    );
  }

  Widget buildCalendar() {
    return Column(
      children: [
        TableCalendar(
          locale: "en-US",
          headerStyle: const HeaderStyle(
              formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today,
          firstDay: DateTime.utc(2023, 11, 24),
          lastDay: DateTime.utc(2099, 12, 31),
          onDaySelected: _onDaySelected,
        )
      ],
    );
  }
}

Widget buildTasksRectangle(String textTitle) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 15, left: 20, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Agrupa o título e o ícone de notificação em uma coluna
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textTitle,
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 45, 45, 45),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.notification_important_rounded,
                    size: 25,
                    color: Color.fromARGB(255, 45, 45, 45),
                  ),
                  const SizedBox(
                      width: 4), // Adiciona um espaço entre o ícone e o texto
                  Text(
                    '12:00',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert, size: 35),
          ),
        ],
      ),
    ),
  );
}
