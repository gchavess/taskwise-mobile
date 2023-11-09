import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 71, 178),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.notifications_rounded,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      AssetImage('imagemTeste.jpg'),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Atividade',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 100),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            constraints: const BoxConstraints(
                                minHeight: 0, maxHeight: 95),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(9),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(44, 0, 0, 0),
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Icon(
                                    Icons.calendar_today_rounded,
                                    color: Color.fromARGB(255, 0, 71, 178),
                                    size: 50,
                                  ),
                                ),
                                Text(
                                  'Calendário',
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: const Color.fromARGB(
                                          255, 45, 45, 45)),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            constraints: const BoxConstraints(
                                minHeight: 0, maxHeight: 95),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(9),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(44, 0, 0, 0),
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Icon(
                                    Icons.watch_later_outlined,
                                    color: Color.fromARGB(255, 0, 71, 178),
                                    size: 50,
                                  ),
                                ),
                                Text(
                                  'Pomodoro',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 45, 45, 45)),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            width: 100,
                            constraints: const BoxConstraints(
                                minHeight: 0, maxHeight: 95),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(9),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(44, 0, 0, 0),
                                    blurRadius: 6,
                                    spreadRadius: 4,
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Icon(
                                    Icons.layers_outlined,
                                    color: Color.fromARGB(255, 0, 71, 178),
                                    size: 50,
                                  ),
                                ),
                                Text(
                                  'Metas',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 45, 45, 45)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 15)
            ],
          ),
        ));
  }
}
