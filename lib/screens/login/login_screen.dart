import 'package:flutter/material.dart';
import 'package:task_wise_frontend/screens/home/home.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:task_wise_frontend/providers/app_state.dart';
import 'package:flutter/gestures.dart';
import 'package:task_wise_frontend/screens/login/sign_up_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? _usernameController = TextEditingController();
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _passwordController = TextEditingController();

  Color pageDetailColor = Color(0xFF0047B2);
  Color inputDetailColor = Color(0xFF0047B2);
  Color textColor =
      Color.fromARGB(255, 63, 63, 63); // Color for text field details

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String? email = _emailController?.text;
      final String? senha = _passwordController?.text;

      if (email != null && senha != null) {
        Map<String, dynamic> requestBody = {
          'email': email,
          'senha': senha,
        };

        Dio dio = Dio();

        String requestBodyJson = jsonEncode(requestBody);

        try {
          Response response = await dio.post(
            'https://taskwise-backend.cyclic.cloud/login',
            data: requestBodyJson,
            options: Options(
              headers: {'Content-Type': 'application/json'},
            ),
          );

          if (response.statusCode == 200) {
            final appState = Provider.of<AppState>(context, listen: false);
            appState.setResponseData(response.data['user']['nome'].toString());

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  userName: response.data['user']['nome'].toString(),
                ),
              ),
            );
          }

          print('Corpo da resposta: ${response.data}');
        } catch (e) {
          print('Erro ao fazer a requisição: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            // Center the Column vertically
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the Column vertically
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft, // Align text to the left
                      child: Text(
                        'Entrar no TaskWise', // Text above the email field
                        style: TextStyle(
                          color: textColor, // Set the text color to pink
                          fontWeight: FontWeight.bold, // Set the text to bold
                          fontSize: 22
                        ),
                      ),
                    ),
                    SizedBox(
                        height:
                            16), // Space between the text and the email field
                    _buildRoundedTextField(
                      controller: _emailController,
                      labelText: 'E-mail',
                      detailColor: inputDetailColor,
                    ),
                    SizedBox(height: 20),
                    _buildRoundedTextField(
                      controller: _passwordController,
                      labelText: 'Senha',
                      isPassword: true,
                      detailColor: inputDetailColor,
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment:
                          Alignment.centerRight, // Align text to the left
                      child: Text(
                        'Esqueceu sua senha?', // Text above the email field
                        style: TextStyle(
                          color: inputDetailColor, // Set the text color to pink
                          fontWeight: FontWeight.bold, // Set the text to bold
                          fontSize: 16
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () => _submitForm(context),
                      child: Container(
                        width: double
                            .infinity, // Set the button's width to match the parent
                        height:
                            50.0, // Set the button's height to the desired value
                        child: Center(
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize:
                                  19, // You can adjust the text size if needed
                            ),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pageDetailColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 110.0), // Adiciona padding-top de 100.0
                          child: Text('Não tem uma conta?'),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Inscrever-se no Taskwise.',
                                style: TextStyle(
                                  color: Color(
                                      0xFFFF0047B2), // Define a cor do texto como rosa
                                  decoration: TextDecoration
                                      .underline, // Adiciona sublinhado
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Adicione o código para navegar para a SignUpPage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpPage()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController? controller,
    required String labelText,
    bool isPassword = false,
    required Color detailColor,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: textColor), // Set the text color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide:
              BorderSide(color: detailColor), // Set the field detail color
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
}
