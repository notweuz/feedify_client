import 'package:dio/dio.dart';
import 'package:feedify/app/app_data.dart';
import 'package:feedify/repositories/auth/auth_repository.dart';
import 'package:feedify/repositories/auth/models/register_dto.dart';
import 'package:flutter/material.dart';

import '../widget/widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _displayNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();

  static const String _passwordMismatchTitle = 'Ошибка!';
  static const String _passwordMismatchMessage = 'Пароли не совпадают.';
  static const String _registrationErrorTitle = 'Ошибка регистрации';
  static const String _userExistsMessage =
      'Пользователь с таким именем уже существует';
  static const String _registrationErrorMessage =
      'Произошла ошибка во время регистрации';

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_passwordController.text != _passwordAgainController.text) {
      await ErrorDialog.show(
        context,
        title: _passwordMismatchTitle,
        message: _passwordMismatchMessage,
      );
      return;
    }

    try {
      final authDTO = await AuthRepository.register(
        RegisterDTO(
          displayName: _displayNameController.text,
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );

      AppData.userToken = authDTO.accessToken;
      AppData.saveData();
      if (mounted) Navigator.pushNamed(context, '/app/');
    } on DioException catch (e) {
      String errorMessage;

      if (e.response != null) {
        if (e.response!.statusCode == 409) {
          errorMessage = _userExistsMessage;
        } else {
          errorMessage = 'Ошибка сервера: ${e.response!.statusCode}';
        }
      } else {
        errorMessage = _registrationErrorMessage;
      }

      if (mounted) {
        await ErrorDialog.show(
          context,
          title: _registrationErrorTitle,
          message: errorMessage,
        );
      }
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
            RegisterControls(
              displayNameController: _displayNameController,
              usernameController: _usernameController,
              passwordController: _passwordController,
              passwordAgainController: _passwordAgainController,
              registerButtonCallback: _register,
            ),
          ],
        ),
      ),
    );
  }
}
