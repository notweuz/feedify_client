import 'package:flutter/material.dart';

class RegisterControls extends StatelessWidget {
  final TextEditingController displayNameController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordAgainController;
  final VoidCallback registerButtonCallback;

  const RegisterControls({
    super.key,
    required this.displayNameController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordAgainController,
    required this.registerButtonCallback,
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
            controller: displayNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Отображаемое имя (необяз.)",
            ),
          ),
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
          TextField(
            obscureText: true,
            controller: passwordAgainController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Пароль (заново)",
            ),
          ),
          SizedBox(height: 10),
          FilledButton(onPressed: registerButtonCallback, child: Text('Зарегистрироваться')),
        ],
      ),
    );
  }
}
