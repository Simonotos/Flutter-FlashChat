import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String userEmail = "";
  String userPasword = "";
  bool progressIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: progressIndicator,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
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
                    userEmail = value.trim();
                  },
                  style: kInputFieldText,
                  decoration: kInputFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  onChanged: (value) {
                    userPasword = value.trim();
                  },
                  style: kInputFieldText,
                  obscureText: true,
                  decoration: kInputFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RoundedButton(
                  onPressed: () async {

                    setState(() {
                      progressIndicator = true;
                    });

                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: userEmail, password: userPasword);

                      if (user != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }

                      setState(() {
                        progressIndicator = false;
                      });

                    } catch (e) {
                      print(e);
                    }
                  },
                  buttonColor: Colors.lightBlueAccent,
                  buttonText: 'Log in',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
