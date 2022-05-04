import 'package:flutter/material.dart';
import '../../styling_files/constants.dart';
import '../../data_files/step_by_step_stroke_data.dart';
import '../../data_files/character_to_wylie.dart';
import 'drawn_stroke.dart';


class PracticeCharacterPage extends StatefulWidget {
  String character;
  List strokeChars;
  List gradientData;
  PracticeCharacterPage(String this.character, {Key key}){
    String temp = characterToStrokeUnicode[this.character];
    gradientData = characterToGradientData[this.character];

    strokeChars  = [];
    for (int i =0; i<temp.length; i++){
      if (temp[i]!=" "){
        strokeChars.add(temp[i]);
      }else{
        List<String> subStrokeList = [];
        i+=1;
        while(i<temp.length && temp[i]!=" "){
          subStrokeList.add(temp[i]);
          i+=1;
        }
        if (subStrokeList.isNotEmpty){
          strokeChars.add(subStrokeList);
        }
      }
    }
    print(strokeChars);
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
    stackList.add(DrawnStroke(widget.strokeChars[this.strokeIdx],
      key: ValueKey(strokeIdx),
      shaderCallback: widget.gradientData[strokeIdx].shaderCallback
    ));

    if (this.strokeIdx > 0){
      var prevChar = widget.strokeChars[this.strokeIdx-1];
      if(prevChar is List){
        prevChar = prevChar[prevChar.length-1];
      }
      stackList.add(Text(prevChar.toString(),
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
              Text(characterToWylie[widget.character]),

              Container(
                width: 275,
                height: 570,
                color: Colors.white,
                alignment: Alignment.center,
                child: Stack(
                  children: stackList,
                  alignment: Alignment.center
                )
              ),

              Row(//Controls
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
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
                ]
              ),
            ]
          )
        )
      );
    }
  }

