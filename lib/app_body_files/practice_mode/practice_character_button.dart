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
    Size screenDims = MediaQuery.of(context).size;
    double sdm = screenDims.width / kDevScreenWidth;

    return Container(
      width: 44*sdm,
      height: 59*sdm,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0x72FFFFFF),
          padding: EdgeInsets.all(1*sdm),
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11.5*sdm))
          )
        ),
        onPressed: ()=>Navigator.pushNamed(context, "/"+ widget.letter),
        child: Stack(
          children: <Widget>[

            Positioned.fill(
              top:characterToTopPadding[widget.letter]*sdm,
              child: Text(widget.letter,
                style: TextStyle(
                  fontSize: 39,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2.5*sdm
                    ..color = Color(0x34ffffff)
                ),
                textScaleFactor: sdm,
                textAlign: TextAlign.center,
              ),
            ),
            Positioned.fill(
              top:characterToTopPadding[widget.letter]*sdm,
              child: Text(widget.letter,
                style: TextStyle(
                  color: Color(0xFFAE881E),
                  //0xFF9B7A1D
                  fontSize:39,
                ),
                textScaleFactor: sdm,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
