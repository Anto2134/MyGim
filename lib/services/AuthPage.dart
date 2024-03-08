// ignore_for_file: prefer_const_constructors, empty_catches, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  Map data = {"email": "", "password": ""};

  Future<void> signIn() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } on FirebaseAuthException catch (error) {}
  }

  Future<void> createUser() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } on FirebaseAuthException catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('PAGINA DI LOGIN'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'inserisci email';
                }
                return null;
              },
              controller: _email,
              decoration: InputDecoration(label: Text('email')),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Inserisci password';
                }
                return null;
              },
              onSaved: (value) {
                data['email'] = value;
              },
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(label: Text('password')),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                  isLogin ? signIn() : createUser();
                },
                child: Text(isLogin ? 'Accedi' : 'Registrati')),
            TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(isLogin
                    ? 'Non hai un account? Registrati'
                    : 'Hai un account? Accedi'))
          ],
        ),
      ),
    );
  }
}
