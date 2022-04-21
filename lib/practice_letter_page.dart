import 'package:flutter/material.dart';
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';
import 'character_writing_pad.dart';
import 'data_files/character_to_wylie.dart';


class PracticeCharacterPage extends StatefulWidget {
  String character;
  PracticeCharacterPage(String this.character, {Key key}) : super(key: key);

  @override
  _PracticeCharacterPageState createState() => _PracticeCharacterPageState();
}

class _PracticeCharacterPageState extends State<PracticeCharacterPage> {
  @override
  Widget build(BuildContext context) {

    Size screenDims = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    double sdm = screenDims.width / kDevScreenWidth;
    double safeScreenHeight= screenDims.height-padding.top-padding.bottom;
    double safeScreenWidth = screenDims.width-padding.left -padding.right;

    return SafeArea(
        child: Container(
            width: safeScreenWidth,
            height: safeScreenHeight,
            color:Color(0xff3896d4),
            child: Column(
              children: <Widget>[
                // Text(widget.character),
                Text(characterToWylie[widget.character]),
                CharacterWritingPad(widget.character),
                Row(//Controls
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextButton(child: Container(width: 100, height: 100, color: Colors.black), onPressed: ()=>{}),
                    TextButton(child: Container(width: 100, height: 100, color: Colors.black),onPressed: ()=>{}),

                  ]
                ),
              ]
            )

        )
    );
  }
}
