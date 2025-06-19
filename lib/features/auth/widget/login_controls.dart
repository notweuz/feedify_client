import 'package:feedify/l10n/app_localizations.dart';
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
    final localization = AppLocalizations.of(context)!;
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.0,
        children: [
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localization.loginUsernameLabel,
            ),
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: localization.loginPasswordLabel,
            ),
          ),
          SizedBox(height: 10),
          FilledButton(onPressed: loginButtonCallback, child: Text(localization.loginButtonText)),
        ],
      ),
    );
  }
}
