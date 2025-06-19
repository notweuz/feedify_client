import 'package:dio/dio.dart';
import 'package:feedify/app/app_data.dart';
import 'package:feedify/features/auth/widget/widget.dart';
import 'package:feedify/l10n/app_localizations.dart';
import 'package:feedify/repositories/auth/auth_repository.dart';
import 'package:feedify/repositories/auth/models/login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final localizations = AppLocalizations.of(context)!;
    try {
      final auth = await AuthRepository.login(
        Login(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
      );

      AppData.userToken = auth.accessToken;
      AppData.saveData();
      if (mounted) {
        Navigator.pushNamed(context, '/app/');
      }
    } on DioException catch (e) {
      String errorMessage;

      if (e.response != null) {
        if (e.response!.statusCode == 400) {
          errorMessage = localizations.loginWrongPasswordMessage;
        } else if (e.response!.statusCode == 404) {
          errorMessage = localizations.loginNoSuchUserMessage;
        } else {
          errorMessage = localizations.loginServerErrorMessage(
            e.response!.statusCode.toString(),
          );
        }
      } else {
        errorMessage = localizations.loginErrorMessage;
      }

      if (mounted) {
        await ErrorDialog.show(
          context,
          title: localizations.loginErrorTitle,
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
