import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final String userName;

  const HomePage({
    Key? key,
    required this.userName,
  }) : super(key: key);

  Widget buildProfileSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            // Lidar com o toque no ícone de notificação
          },
          child: const Icon(
            Icons.notifications_rounded,
            color: Colors.white,
            size: 40,
          ),
        )
      ],
    );
  }

  Widget buildGreetingText() {
    return Text(
      'Olá, $userName!',
      style: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }

  Widget buildButton(
      String label, IconData icon, Color iconColor, VoidCallback onPressed) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(7),
          constraints: const BoxConstraints(minHeight: 0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(9),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(44, 0, 0, 0),
                blurRadius: 6,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  shape: BoxShape.rectangle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 50,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 45, 45, 45),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonsRow() {
    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildButton('Calendário', Icons.calendar_today_rounded,
              const Color.fromARGB(255, 0, 71, 178), () {}),
          const SizedBox(width: 18),
          buildButton('Pomodoro', Icons.watch_later_outlined,
              const Color.fromARGB(255, 0, 71, 178), () {}),
          const SizedBox(width: 18),
          buildButton('Metas', Icons.layers_outlined,
              const Color.fromARGB(255, 0, 71, 178), () {}),
        ],
      ),
    );
  }

  Widget buildGoalsRectangle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
        margin: const EdgeInsets.only(top: 25, left: 25, right: 22),
        padding:
            const EdgeInsets.only(top: 17, left: 20, right: 15, bottom: 12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Metas',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 45, 45, 45),
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 7),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildInkWell('Meta 01',
                      const Color.fromARGB(255, 255, 88, 88), '1 de 1'),
                  buildInkWell('Meta 02',
                      const Color.fromARGB(255, 30, 214, 255), '1 de 1'),
                  buildInkWell('Meta 03', const Color.fromARGB(255, 0, 163, 36),
                      '1 de 1'),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildInkWell('Meta 04', const Color.fromARGB(255, 66, 66, 66),
                      '1 de 1'),
                  buildInkWell('Meta 05',
                      const Color.fromARGB(255, 255, 175, 54), '1 de 1'),
                  buildInkWell('Meta 06',
                      const Color.fromARGB(255, 165, 0, 148), '1 de 1'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInkWell(String label, Color color, String progressText) {
    return InkWell(
      onTap: () {
        // Lidar com o toque no InkWell
      },
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(9),
        ),
        margin: const EdgeInsets.all(7),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 6),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 6),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  progressText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTasksRectangle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
        margin: const EdgeInsets.only(top: 20, left: 25, right: 22, bottom: 40),
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Tarefas do dia',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: const Color.fromARGB(255, 45, 45, 45),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 1),
            buildTaskWithCheckbox('Tarefa 1'),
            buildTaskWithCheckbox('Tarefa 2'),
            buildTaskWithCheckbox('Tarefa 3'),
          ],
        ),
      ),
    );
  }

  Widget buildTaskWithCheckbox(String task) {
    bool isChecked = false;

    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {},
        ),
        const SizedBox(width: 10),
        Text(
          task,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 71, 178),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25),
            buildProfileSection(),
            const SizedBox(height: 20),
            Row(
              children: [
                //buildAvatar(),
                const SizedBox(
                  width: 35,
                ),
                buildGreetingText(),
              ],
            ),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.only(
                  top: 30, left: 20, right: 20, bottom: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: buildButtonsRow(),
            ),
            Container(
              color: Colors.white, // Cor do fundo branco
              height: 305,
              child: buildGoalsRectangle(),
            ),
            Container(
              color: Colors.white, // Cor do fundo branco
              child: buildTasksRectangle(),
            ),
          ],
        ),
      ),
    );
  }
}
