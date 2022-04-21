import 'package:flutter/material.dart';


class PracticeCharacterButton extends StatefulWidget {
  String letter;

  PracticeCharacterButton(this.letter, {Key key}) : super(key: key);

  @override
  _PracticeLetterState createState() => _PracticeLetterState();
}

class _PracticeLetterState extends State<PracticeCharacterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          primary: Colors.black,
          onSurface: Colors.white

        ),
        onPressed: ()=>{},
        child: Text(widget.letter)
      ),
    );

  }
}
