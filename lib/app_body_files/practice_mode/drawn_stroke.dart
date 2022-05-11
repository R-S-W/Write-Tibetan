/*
  DrawnStroke is a widget that draws and animates the step-by-step strokes of
  a Tibetan character.
*/


import 'package:flutter/material.dart';
import '../../styling_files/constants.dart';

class DrawnStroke extends StatefulWidget {
  String character;
  Function shaderCallback;
  List<String> partialChars;
  bool isSingularCharacter = true;
  double sdm;
  DrawnStroke(currentChar,{@required this.shaderCallback, @required this.sdm, Key key}) :super(key: key) {
    if (currentChar is String){
      this.character = currentChar;
      this.isSingularCharacter = true;
    }else if (currentChar is List){
      this.partialChars = currentChar;
      this.isSingularCharacter = false;
    }else{
      this.character = "";
      this.isSingularCharacter = true;
    }
  }

  @override
  _DrawnStrokeState createState() => _DrawnStrokeState();
}

class _DrawnStrokeState extends State<DrawnStroke> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation _animation;
  int characterStepIdx = 0;


  @override
  void initState(){
    _animationController  = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)..addListener((){
      if (
        !widget.isSingularCharacter &&
        _animation.value>(this.characterStepIdx+1)/widget.partialChars.length &&
        this.characterStepIdx< widget.partialChars.length-1
      ){
        setState((){
          this.characterStepIdx +=1;
        });
      }else{
        setState((){});
      }
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    String currentChar = (widget.isSingularCharacter) ?
      widget.character : widget.partialChars[this.characterStepIdx];

    Widget shaderMaskChild = Text(currentChar,
      style: TextStyle(
        fontFamily: kNotoSansTibetanStroke,
        fontSize: kPracticeCharStrokeSize,
        color: kPracticeCharacterPageCanvasColor
      ),
      textScaleFactor: widget.sdm,
    );
    Widget prevLetter = (!widget.isSingularCharacter && this.characterStepIdx >0) ?
      Text(widget.partialChars[this.characterStepIdx-1],
        style: TextStyle(
          fontFamily:kNotoSansTibetanStroke,
          fontSize: kPracticeCharStrokeSize,
          color: Colors.black,
        ),
        textScaleFactor: widget.sdm,
      )
      :
      Container();


    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ShaderMask(
          child:
          shaderMaskChild,
          shaderCallback: (widget.isSingularCharacter) ?
            widget.shaderCallback(_animation.value) :
            widget.shaderCallback(this.characterStepIdx,_animation.value)
        ),
        prevLetter
      ]
    );
  }
}
