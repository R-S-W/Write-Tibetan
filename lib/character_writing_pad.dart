import 'package:flutter/material.dart';



class CharacterWritingPad extends StatefulWidget {
  String character;
  CharacterWritingPad(String this.character, {Key key}) : super(key: key);

  @override
  _CharacterWritingPadState createState() => _CharacterWritingPadState();
}

class _CharacterWritingPadState extends State<CharacterWritingPad> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 400, width: 400, color: Colors.white);
  }
}
