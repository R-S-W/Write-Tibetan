import 'package:flutter/material.dart';
import '../../data_files/character_to_gradient_data.dart';
import '../../styling_files/constants.dart';
import '../../data_files/character_to_stroke_unicode.dart';
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
  //Used to rebuild widget if user presses left button on the first animated
  //stroke, reanimating it.
  int leftButtonNumber = 0;

  @override
  Widget build(BuildContext context) {

    Size screenDims = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    double sdm = screenDims.width / kDevScreenWidth;
    double safeScreenHeight= screenDims.height-padding.top-padding.bottom;
    double safeScreenWidth = screenDims.width-padding.left -padding.right;

    //Widget that has the animation for the main Stack widget below.
    List<Widget> stackList = <Widget>[];
    stackList.add(DrawnStroke(widget.strokeChars[this.strokeIdx],
      key: ValueKey(strokeIdx+leftButtonNumber),
      sdm: sdm,
      shaderCallback: widget.gradientData[strokeIdx].shaderCallback
    ));

    //Draw the character with all the previously drawn strokes behind DrawnStroke
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
        ),
        textScaleFactor: sdm
      ));
    }


      return SafeArea(
        child: Container(
          width: safeScreenWidth,
          height: safeScreenHeight,
          color:kPracticeCharacterPageCanvasColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(//Top bar
                  color: kAppBarBackgroundColor,
                  width: safeScreenWidth,
                  height: 50*sdm,
                  padding: EdgeInsets.symmetric(horizontal: 30*sdm),
                  child: Stack(
                      children:[
                        Align(
                          alignment: Alignment(-1.0,-0.2),
                          child: Container(//Back to StartScreen
                            width: 25*sdm,
                            height: 25*sdm,
                            child: IconButton(
                                icon: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 24*sdm,
                                    color: kTWhite
                                ),
                                onPressed: ()=>Navigator.pop(context),
                                padding: EdgeInsets.zero
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment(0.0,1.0),
                          child: Text(
                            characterToWylie[widget.character],
                            style: TextStyle(
                                fontFamily:kMohave,
                                fontSize:35,
                                // fontWeight: FontWeight.w700,
                                color: kTWhite
                            ),
                            textScaleFactor: sdm,
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              // Text(characterToWylie[widget.character]),


              Container(
                width: 275*sdm,
                height: 570*sdm,
                color: kPracticeCharacterPageCanvasColor,
                child: Stack(
                  children: stackList,
                  alignment: Alignment.center
                )
              ),

              Align(//Controls
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: kAppBarBackgroundColor,
                  height:90*sdm,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon:Icon(Icons.keyboard_arrow_left_outlined),
                        iconSize: 80*sdm,
                        color:Colors.white,
                        onPressed: (){
                          setState((){
                            if (this.strokeIdx>0){
                              this.strokeIdx-=1;
                            }else{
                              this.leftButtonNumber= (this.leftButtonNumber+1)%2;
                            }
                          });
                        }
                      ),
                      SizedBox(width: 50*sdm),
                      IconButton(
                        icon:Icon(Icons.keyboard_arrow_right_outlined),
                        iconSize:80*sdm,
                        color:Colors.white,
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
                ),
              )
            ]
          )
        )
      );
    }
  }

