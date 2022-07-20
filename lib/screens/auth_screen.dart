import 'package:chat_with_us/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/auth/auth_form_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  var _isLoading = false;

  Future<void> _submitAuthForm(String email, String username, String password,
      bool isLogin, BuildContext ctx) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _firestore
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({'username': username, 'email': email});
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      var msg = 'An error occurred, please check your credentials!';
      if (e.message != null) {
        msg = e.message ?? '';
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      logger.e('$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthFormWidget(submitForm: _submitAuthForm, isLoading: _isLoading),
    );
  }
}
