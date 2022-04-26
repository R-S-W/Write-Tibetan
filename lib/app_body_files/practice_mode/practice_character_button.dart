import 'package:flutter/material.dart';


class PracticeCharacterButton extends StatefulWidget {
  String letter;

  PracticeCharacterButton(this.letter, {Key key}) : super(key: key);

  @override
  _PracticeCharacterState createState() => _PracticeCharacterState();
}

class _PracticeCharacterState extends State<PracticeCharacterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          primary: Colors.black,
          onSurface: Colors.white
        ),
        onPressed: ()=>Navigator.pushNamed(context, "/"+ widget.letter),
        child: Text(widget.letter)
      ),
    );

  }
}
