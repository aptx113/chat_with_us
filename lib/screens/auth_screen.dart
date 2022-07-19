import 'package:flutter/material.dart';

import '../widgets/auth_form_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm(
      String email, String username, String password, bool isLogin) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFormWidget(submitForm: _submitAuthForm),
    );
  }
}
