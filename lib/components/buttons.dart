import 'package:flutter/material.dart';
import '../const.dart';

class BottomButton extends StatelessWidget {

  BottomButton(this.bText, this.bColour, this.onpressed);
  final bText;
  final bColour;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: bColour,
      borderRadius: BorderRadius.circular(10.0),
      child: MaterialButton(
        onPressed: onpressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          bText,style: kButtonTextStyle,
        ),
      ),
    );
  }
}
