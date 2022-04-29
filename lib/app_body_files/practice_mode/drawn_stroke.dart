


import 'package:flutter/material.dart';
import '../../styling_files/constants.dart';

class DrawnStroke extends StatefulWidget {
  String character;
  Function shaderCallback;
  DrawnStroke(this.character,{@required this.shaderCallback, Key key}) :
    super(key: key);

  @override
  _DrawnStrokeState createState() => _DrawnStrokeState();
}

class _DrawnStrokeState extends State<DrawnStroke> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState(){
    _animationController  = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)..addListener((){
      setState((){
      });
    });
    _animationController.forward();
    super.initState;
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShaderMask(
        child:
        Text(
          widget.character,
          style: TextStyle(
            fontFamily: kNotoSansTibetanStroke,
            fontSize: kPracticeCharStrokeSize,
            color: Colors.white
          ),
        ),
        // Container(
        //   width: 200,height: 400,color: Colors.white
        // ),
        shaderCallback:
        widget.shaderCallback(_animation.value),
      ),
    );
  }
}
