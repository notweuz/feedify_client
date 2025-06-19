import 'package:dio/dio.dart';
import 'package:feedify/app/app_data.dart';
import 'package:feedify/l10n/app_localizations.dart';
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

  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    var localizations = AppLocalizations.of(context)!;
    if (_passwordController.text != _passwordAgainController.text) {
      await ErrorDialog.show(
        context,
        title: localizations.registerPasswordMismatchTitle,
        message: localizations.registerPasswordMismatchMessage,
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
          errorMessage = localizations.registerSameUsernameExistsMessage;
        } else {
          errorMessage = localizations.registerServerErrorMessage(
            e.response!.statusCode.toString(),
          );
        }
      } else {
        errorMessage = localizations.registerErrorMessage;
      }

      if (mounted) {
        await ErrorDialog.show(
          context,
          title: localizations.registerErrorTitle,
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
