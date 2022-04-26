


import 'package:flutter/material.dart';
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';

class DrawnStroke extends StatefulWidget {
  String character;
  DrawnStroke(this.character,{Key key}) : super(key: key);

  @override
  _DrawnStrokeState createState() => _DrawnStrokeState();
}

class _DrawnStrokeState extends State<DrawnStroke> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation _animation;

  @override
  void initState(){
    animationController  = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(animationController)..addListener((){
      setState((){
      });
    });
    animationController.forward();
    super.initState;
  }

  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShaderMask(
        child: Text(
          widget.character,
          style: TextStyle(
            fontFamily: kNotoSansTibetanStroke,
            fontSize: kPracticeCharStrokeSize,
            color: Colors.white
          ),
        ),
        shaderCallback: (rect)=>LinearGradient(
            colors: [Colors.black, Colors.white],
            stops: [_animation.value,_animation.value]
          ).createShader(rect),
        //     textAlign
      ),
    );
  }
}
