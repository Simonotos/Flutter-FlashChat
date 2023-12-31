import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {

  static const String id = 'register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;

  String emailTyped = "";
  String passwordTyped = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                emailTyped = value.trim();
              },
              style: kInputFieldText,
              decoration: kInputFieldDecoration.copyWith(hintText: 'Enter your email')
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                passwordTyped = value.trim();
              },
              style: kInputFieldText,
              obscureText: true,
              decoration: kInputFieldDecoration.copyWith(hintText: 'Enter your password')
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RoundedButton(
                onPressed: () async{
                  try{
                    _auth.createUserWithEmailAndPassword(email: emailTyped, password: passwordTyped);
                  }
                  catch(e){
                    print(e);
                  }
                },
                buttonColor: Colors.blueAccent,
                buttonText: 'Register',
              )
            ),
          ],
        ),
      ),
    );
  }
}
