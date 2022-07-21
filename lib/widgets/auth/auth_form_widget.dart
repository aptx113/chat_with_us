import 'package:flutter/material.dart';

import '../pickers/user_image_picker_widget.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget(
      {Key? key, required this.submitForm, required this.isLoading})
      : super(key: key);

  final void Function(String email, String username, String password,
      bool isLogin, BuildContext ctx) submitForm;

  final bool isLoading;

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      widget.submitForm(
          _userEmail, _userName, _userPassword, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePickerWidget(),
                TextFormField(
                  key: const ValueKey('userEmail'),
                  validator: (value) {
                    return (value != null && value.isEmpty ||
                            value != null && !value.contains('@'))
                        ? 'Please enter a valid email address.'
                        : null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email address'),
                  onSaved: (newValue) {
                    _userEmail = newValue ?? '';
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('userName'),
                    validator: (value) => (value != null && value.isEmpty ||
                            value != null && value.length < 4)
                        ? 'Please enter at least 4 characters'
                        : null,
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: (newValue) {
                      _userName = newValue ?? '';
                    },
                  ),
                TextFormField(
                  key: const ValueKey('userPassword'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (newValue) {
                    _userPassword = newValue ?? '';
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                if (!widget.isLoading)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                  )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
