import 'package:flutter/material.dart';

class LoginControls extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback loginButtonCallback;

  const LoginControls({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.loginButtonCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.0,
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Имя пользователя",
            ),
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Пароль",
            ),
          ),
          SizedBox(height: 10),
          FilledButton(onPressed: loginButtonCallback, child: Text('Войти')),
        ],
      ),
    );
  }
}
