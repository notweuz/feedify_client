import 'package:feedify/l10n/app_localizations.dart';
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
    final localization = AppLocalizations.of(context)!;
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.0,
        children: [
          TextField(
            controller: displayNameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localization.registerDisplayNameLabel,
            ),
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localization.registerUsernameLabel,
            ),
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localization.registerPasswordLabel,
            ),
          ),
          TextField(
            obscureText: true,
            controller: passwordAgainController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localization.registerPasswordAgainLabel,
            ),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: registerButtonCallback,
            child: Text(localization.registerButtonText),
          ),
        ],
      ),
    );
  }
}
