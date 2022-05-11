import 'package:flutter/material.dart';

import '../../styling_files/character_to_top_padding.dart';
import '../../styling_files/constants.dart';


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
      width: 42,
      height: 58,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0x72FFFFFF),
          // primary: Color(0xFFC4971C),
          //0xFFB4562E,  0xFF8D4316
            //gold 0xFF8D6F16,0xFFA07D17
          // onSurface: Colors.white,
          padding: EdgeInsets.all(1),
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.5))
          )
        ),
        onPressed: ()=>Navigator.pushNamed(context, "/"+ widget.letter),
        child: Stack(
          children: <Widget>[

            Positioned.fill(
              top:characterToTopPadding[widget.letter],
              child: Text(widget.letter,
                style: TextStyle(
                  fontSize: 37,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2.5*1
                    ..color = Color(0x34ffffff)
                ),
                textScaleFactor: 1,
                textAlign: TextAlign.center,
              ),
            ),
            Positioned.fill(
              top:characterToTopPadding[widget.letter],
              child: Text(widget.letter,
                style: TextStyle(
                  color: Color(0xFFAE881E),
                  //0xFF9B7A1D
                  fontSize:37,
                ),
                textScaleFactor: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        // Text(widget.letter,
        //   style:TextStyle(fontSize: 37)
        // )

      ),
    );

  }
}
