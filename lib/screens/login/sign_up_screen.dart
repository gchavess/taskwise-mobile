import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:task_wise_frontend/screens/login/login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage();

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? _usernameController = TextEditingController();
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _passwordController = TextEditingController();

  Color pageDetailColor = Color(0xFF0047B2);
  Color inputDetailColor = Color(0xFF0047B2);
  Color textColor = Color.fromARGB(255, 63, 63, 63);

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_usernameController != null &&
          _emailController != null &&
          _passwordController != null) {
        Map<String, dynamic> requestBody = {
          'nome': _usernameController?.text,
          'email': _emailController?.text,
          'senha': _passwordController?.text,
        };

        Dio dio = Dio();

        String requestBodyJson = jsonEncode(requestBody);

        try {
          Response response = await dio.post(
            'https://taskwise-backend.cyclic.cloud/users',
            data: requestBodyJson,
            options: Options(
              headers: {'Content-Type': 'application/json'},
            ),
          );
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
                        'Criar conta', // Text above the email field
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
                      controller: _usernameController,
                      labelText: 'Nome',
                      detailColor: inputDetailColor,
                    ),
                    SizedBox(height: 20),
                    _buildRoundedTextField(
                      controller: _passwordController,
                      labelText: 'Senha',
                      isPassword: true,
                      detailColor: inputDetailColor,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Container(
                        width: double
                            .infinity, // Set the button's width to match the parent
                        height:
                            50.0, // Set the button's height to the desired value
                        child: Center(
                          child: Text(
                            'Inscreva-se agora',
                            style: TextStyle(
                              fontSize:
                                  19, // You can adjust the text size if needed
                            ),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: pageDetailColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 100.0), // Adiciona padding-top de 20px
                      child: Text.rich(
                        TextSpan(
                          text: 'Já tem uma conta? ',
                          children: [
                            TextSpan(
                              text: 'Faça login.',
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
                                        builder: (context) => LoginPage()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
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
