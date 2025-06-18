import 'package:dio/dio.dart';
import 'package:feedify/app/app_data.dart';
import 'package:feedify/features/auth/widget/widget.dart';
import 'package:feedify/repositories/auth/auth_repository.dart';
import 'package:feedify/repositories/auth/models/login_dto.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  static const _wrongPasswordMessage = "Неправильный пароль.";
  static const _loginErrorTitle = "Ошибка входа.";
  static const _noUserFoundMessage = "Такого пользователя не существует.";
  static const _loginErrorMessage = "Произошла ошибка во время входа.";

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      final authDTO = await AuthRepository.login(LoginDTO(
          username: _usernameController.text,
          password: _passwordController.text));

      AppData.userToken = authDTO.accessToken;
      AppData.saveData();
      if (mounted) Navigator.pushNamed(context, '/app/');
    } on DioException catch (e) {
      String errorMessage;

      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          errorMessage = _wrongPasswordMessage;
        } else if (e.response!.statusCode == 404) {
          errorMessage = _noUserFoundMessage;
        } else {
          errorMessage = "Ошибка сервера: ${e.response!.statusCode}";
        }
      } else {
        errorMessage = _loginErrorMessage;
      }

      await ErrorDialog.show(context, title: _loginErrorTitle, message: errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Feedify',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            LoginControls(
              usernameController: _usernameController,
              passwordController: _passwordController,
              loginButtonCallback: _login,
            ),
          ],
        ),
      ),
    );
  }
}