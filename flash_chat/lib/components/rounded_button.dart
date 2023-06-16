import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
        required this.onPressed,
        required this.buttonText,
        required this.buttonColor})
      : super(key: key);

  final String buttonText;
  final Color buttonColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: buttonColor,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(buttonText, style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
