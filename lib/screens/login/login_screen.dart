// import 'package:flutter/material.dart';
// // import 'package:form_validator/form_validator.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   Map userData = {};
//   final _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Login'),
//       //   centerTitle: true,
//       // ),
//       body: SingleChildScrollView(
//         child: const Column(
//           children: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(top: 30.0),
//               child: Text('Entre no TaskWise', 
              
//               )
//               ),
//           ]
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Form(
//                     key: _formkey,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                               padding: const EdgeInsets.all(12.0),
//                               child: TextFormField(
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'Por favor, insira um email.';
//                                     }
//                                     return null;
//                                   },
//                                   decoration: const InputDecoration(
//                                       hintText: 'Email',
//                                       labelText: 'Email',
//                                       prefixIcon: Icon(
//                                         Icons.email,
//                                         //color: Colors.green,
//                                       ),
//                                       errorStyle: TextStyle(fontSize: 18.0),
//                                       border: OutlineInputBorder(
//                                           borderSide:
//                                               BorderSide(color: Colors.red),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(9.0)))))),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: TextFormField(
//                               validator: (value) {
//                                 if (value == null ||
//                                     value.isEmpty ||
//                                     value.length < 8) {
//                                   return 'Por favor, insira uma senha (mínimo 8 dígitos)';
//                                 }
//                                 return null;
//                               },
//                               decoration: const InputDecoration(
//                                 hintText: 'Password',
//                                 labelText: 'Password',
//                                 prefixIcon: Icon(
//                                   Icons.key,
//                                   color: Colors.green,
//                                 ),
//                                 errorStyle: TextStyle(fontSize: 18.0),
//                                 border: OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.red),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(9.0))),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.fromLTRB(180, 0, 0, 0),
//                             child: const Text('Forget Password!'),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(28.0),
//                             child: SizedBox(
//                               child: RaisedButton(
//                                 child: const Text(
//                                   'Login',
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 22),
//                                 ),
//                                 onPressed: () {
//                                   if (_formkey.currentState!.validate()) {
//                                     print('form submiitted');
//                                   }
//                                 },
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30)),
//                                 color: Colors.blue,
//                               ),
//                               width: MediaQuery.of(context).size.width,
//                               height: 50,
//                             ),
//                           ),
//                           const Center(
//                             child: Padding(
//                               padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
//                               child: Center(
//                                 child: Text(
//                                   'Ou registre sua conta!',
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.black),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           // Row(
//                           //   mainAxisAlignment: MainAxisAlignment.center,
//                           //   children: [
//                           //     Padding(
//                           //       padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
//                           //       child: Row(
//                           //         children: [
//                           //           SizedBox(
//                           //               height: 40,
//                           //               width: 40,
//                           //               child: Image.asset(
//                           //                 'assets/social.jpg',
//                           //                 fit: BoxFit.cover,
//                           //               )),
//                           //           SizedBox(
//                           //             height: 70,
//                           //             width: 70,
//                           //             child: Image.asset(
//                           //               'assets/vishal.png',
//                           //               fit: BoxFit.cover,
//                           //             ),
//                           //           ),
//                           //           SizedBox(
//                           //             height: 40,
//                           //             width: 40,
//                           //             child: Image.asset(
//                           //               'assets/google.png',
//                           //               fit: BoxFit.cover,
//                           //             ),
//                           //           ),
//                           //         ],
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           Center(
//                             child: Container(
//                               padding: const EdgeInsets.only(top: 50),
//                               child: const Text(
//                                 'SIGN UP!',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.lightBlue,
//                                 ),
//                               ),
//                             ),
//                           )
//                         ]),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     )
//   }

//   RaisedButton(
//       {required Text child,
//       required Null Function() onPressed,
//       required RoundedRectangleBorder shape,
//       required MaterialColor color}) {}

//   // RaisedButton(
//   //     {required Text child,
//   //     required Null Function() onPressed,
//   //     required RoundedRectangleBorder shape,
//   //     required MaterialColor color}) {}
// }
