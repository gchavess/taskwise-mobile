import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  final String userId;

  const CalendarPage({
    super.key,
    required this.userId,
  });

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Map<String, dynamic>> taskDataList = [];
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  Color inputDetailColor = Color(0xFF0047B2);
  Color textColor = Color.fromARGB(255, 63, 63, 63);

  @override
  void dispose() {
    _taskNameController.dispose();
    _expirationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchTodayDataTasks();
  }

  void fetchTodayDataTasks() {
    DateTime today = DateTime.now();

    String formattedDate = "${today.day}/${today.month}/${today.year}";

    fetchDataTasks(formattedDate);
  }

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    String formattedDate = DateFormat('dd/MM/yyyy').format(today);

    fetchDataTasks(formattedDate);
  }

  Widget _buildRoundedTextField({
    required TextEditingController? controller,
    required String labelText,
    bool isPassword = false,
    required Color detailColor,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: textColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: detailColor),
        ),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid $labelText';
        }
        return null;
      },
    );
  }

  void fetchDataTasks(String? data) async {
    final Map<String, dynamic> requestBody = {
      'userId': widget.userId,
      'data': data,
    };

    final String requestBodyJson = json.encode(requestBody);
    print(requestBodyJson);
    final response = await http.post(
      Uri.parse('https://taskwise-backend.cyclic.cloud/tasks/data'),
      headers: {'Content-Type': 'application/json'},
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      final List<dynamic> dataList = json.decode(response.body);

      taskDataList.clear();

      for (var data in dataList) {
        if (data is Map<String, dynamic>) {
          taskDataList.add({
            'goalId': data['goalId'] ?? '',
            'id': data['id'] ?? '',
            'titulo': data['titulo'] ?? '',
            'concluido': data['concluido'] ?? '',
            'data_vencimento': data['hora_fim'] ?? '',
          });
        }
      }

      print(taskDataList);
      setState(() {});
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }
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
                          Visibility(
                            visible: false,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              iconSize: 45,
                            ),
                          ),
                        ],
                      ),
                      buildCalendarRectangle(),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text('Tarefas do dia ${today.day}',
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color.fromARGB(255, 45, 45, 45))),
                        ),
                      ),
                      for (var task in taskDataList)
                        buildTasksRectangle(
                          context,
                          task['id'] ?? '',
                          task['titulo'] ?? '',
                          task['concluido'] == "" ? false : true,
                        ),
                      const SizedBox(height: 1),
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

Widget buildTasksRectangle(
    BuildContext context, String id, String textTitle, bool concluido) {
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
          if (concluido)
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'Concluído',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
