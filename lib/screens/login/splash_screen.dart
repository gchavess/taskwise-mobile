import 'package:flutter/material.dart';
import 'package:task_wise_frontend/screens/login/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('',
        style: TextStyle(
          fontSize: 10.0,
          color: Color.fromARGB(255, 0, 71, 178),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('TaskWise.',
              style: GoogleFonts.leagueSpartan(fontSize: 70.0,
              letterSpacing: -5,
              fontWeight: FontWeight.w900,
              color: const Color.fromARGB(255, 0, 71, 178),
              ),
            ),
            const Text('Começe sua jornada produtiva!',
            style: TextStyle(fontSize: 20.0,
            fontWeight: FontWeight.w800,
            color: Colors.black),
            ),
            const SizedBox(height: 10,),
            const Text('Transforme cada momento em uma \nconquista. Desperte seu potencial\ncom o TaskWise.',
              style: TextStyle(fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                // Coloque ação a ser executada ao pressionar o botão aqui
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 0, 71, 178),
                ),
              ),
              child: const Text('Começar'),
            ),
          ],
        ),
      ),
    );
  }
}
