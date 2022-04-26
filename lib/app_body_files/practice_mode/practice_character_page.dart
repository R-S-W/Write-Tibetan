import 'package:flutter/material.dart';
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';
import '../data_files/character_to_stroke_unicode.dart';
import '../data_files/character_to_wylie.dart';
import '../drawn_stroke.dart';


class PracticeCharacterPage extends StatefulWidget {
  String character;
  String strokeChars;
  PracticeCharacterPage(String this.character, {Key key}){
    strokeChars = characterToStrokeUnicode[this.character];
  }

  @override
  _PracticeCharacterPageState createState() => _PracticeCharacterPageState();
}

class _PracticeCharacterPageState extends State<PracticeCharacterPage> {
  int strokeIdx = 0;

  @override
  Widget build(BuildContext context) {

    Size screenDims = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    double sdm = screenDims.width / kDevScreenWidth;
    double safeScreenHeight= screenDims.height-padding.top-padding.bottom;
    double safeScreenWidth = screenDims.width-padding.left -padding.right;

    List<Widget> stackList = <Widget>[]; //For Stack Widget below
    if (this.strokeIdx == 0){
      stackList.add(DrawnStroke(widget.strokeChars[this.strokeIdx], key: ValueKey(strokeIdx)));
    }else{
      stackList.add(DrawnStroke(widget.strokeChars[this.strokeIdx], key: ValueKey(strokeIdx)));
      stackList.add(Text(widget.strokeChars[this.strokeIdx-1],
        style: TextStyle(
          fontFamily: kNotoSansTibetanStroke,
          fontSize: kPracticeCharStrokeSize,
          color: Colors.black
        ))
      );
    }


    return SafeArea(
        child: Container(
            width: safeScreenWidth,
            height: safeScreenHeight,
            color:Color(0xff3896d4),
            child: Column(
              children: <Widget>[
                // Text(widget.character),
                Text(characterToWylie[widget.character]),
                // CharacterWritingPad('\u0059'),
                Stack(
                  children: stackList
                ),
                Row(//Controls
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // TextButton(child: Container(
                    //   width: 100,
                    //   height: 100,
                    //   color: Colors.black),
                    //   onPressed: ()=>{},
                    //   child:
                    // ),
                    IconButton(
                      icon:Icon(Icons.keyboard_arrow_left_outlined),
                      iconSize: 40,
                      onPressed: (){
                        if (this.strokeIdx>0){
                          setState((){
                            this.strokeIdx-=1;
                            // stackList[0].animationController.forward();
                          });
                        }
                      }
                    ),
                    IconButton(
                        icon:Icon(Icons.keyboard_arrow_right_outlined),
                        iconSize:40,
                        onPressed: (){
                          if (this.strokeIdx<widget.strokeChars.length-1){
                            setState((){
                              this.strokeIdx+=1;
                            });
                          }
                        }
                    ),
                    // TextButton(child: Container(width: 100, height: 100, color: Colors.black),onPressed: ()=>{}),

                  ]
                ),
              ]
            )

        )
    );
  }
}