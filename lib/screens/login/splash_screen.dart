import 'package:flutter/material.dart';
import 'package:task_wise_frontend/screens/login/login_screen.dart';
import 'package:task_wise_frontend/screens/login/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'TaskWise.',
              style: GoogleFonts.leagueSpartan(
                fontSize: 70.0,
                letterSpacing: -5,
                fontWeight: FontWeight.w900,
                color: const Color.fromARGB(255, 0, 71, 178),
              ),
            ),
            const Text(
              'Comece sua jornada produtiva!',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Transforme cada momento em uma \nconquista. Desperte seu potencial\ncom o TaskWise.',
              style: TextStyle(
                  fontSize: 15.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
          
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 0, 71, 178),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(300, 50),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Ajuste o valor conforme necessário
                  ),
                ),
              ),

              child: const Text('Começar',
              style: TextStyle(
                fontSize: 19 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
