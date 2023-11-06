import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Container(
              padding: const EdgeInsets.all(48),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: const BorderRadius.all(Radius.circular(24))),
              child: Wrap(
                runSpacing: 20,
                children: [
                  const SizedBox(
                      width: double.infinity,
                      child: AppTitle(title: 'Criar Conta')),
                  const InputText(placeholder: 'Nome Completo'),
                  const InputText(placeholder: 'Email'),
                  const InputText(placeholder: 'Senha'),
                  const InputText(placeholder: 'Confirme sua Senha'),
                  // const SizedBox(
                  //     width: double.infinity,
                  //     child: AppText(
                  //       text: 'Ao criar uma conta, ',
                  //       textAlign: TextAlign.end,
                  //     )),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          textStyle: const TextStyle(fontSize: 16),
                          backgroundColor: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Escreva-se agora')),
                  ),
                  Row(
                    children: [
                      const AppText(text: 'Já tem uma conta?'),
                      AppText(
                        text: 'Faça login!',
                        textAlign: TextAlign.end,
                        color: Colors.blue.shade600,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  const AppText({super.key, required this.text, this.textAlign, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(color: color ?? Colors.blue.shade700),
        ));
  }
}

class InputText extends StatelessWidget {
  final String? placeholder;
  const InputText({super.key, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          hintText: placeholder,
          filled: true,
          fillColor: Colors.grey.withOpacity(0.1),
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.5),
          )),
    );
  }
}

class AppTitle extends StatelessWidget {
  final String title;
  const AppTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
    );
  }
}
