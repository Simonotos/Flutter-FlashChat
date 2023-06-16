import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    animController?.forward();
    animController?.addListener(() {
      setState(() {});
    });
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                    TypewriterAnimatedText('Flash Chat',
                        speed: const Duration(milliseconds: 130),
                        textStyle: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w600)),
                  ]),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: RoundedButton(
                  buttonText: 'Log in',
                  buttonColor: Colors.lightBlueAccent,
                  onPressed: () =>
                      {Navigator.pushNamed(context, LoginScreen.id)}),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: RoundedButton(
                  buttonText: 'Register',
                  buttonColor: Colors.lightBlue,
                  onPressed: () =>
                      {Navigator.pushNamed(context, RegistrationScreen.id)}),
            ),
          ],
        ),
      ),
    );
  }
}