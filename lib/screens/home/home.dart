import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_wise_frontend/screens/goals/my_goals.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget buildProfileSection() {
    return Row(
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

  Widget buildAvatar() {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 20, top: 0, right: 5), // Ajuste a margem superior
          child: CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('imagemTeste.jpg'),
          ),
        ),
      ],
    );
  }

  Widget buildGreetingText() {
    return Text(
      'Olá, Fulano!',
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
        onTap: () {
          // Navegar para a rota correspondente quando o botão é pressionado
          onPressed;
        },
        child: Container(
          padding: const EdgeInsets.all(7),
          constraints: const BoxConstraints(minHeight: 0, maxHeight: 95),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 71, 178),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            buildProfileSection(),
            Row(
              children: [
                buildAvatar(),
                const SizedBox(
                  width: 45,
                ),
                buildGreetingText(),
              ],
            ),
            const SizedBox(height: 100),
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
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
                      const Color.fromARGB(255, 0, 71, 178), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyGoals()));
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
