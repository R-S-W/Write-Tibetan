//CustomPainters


import 'dart:ui';
import 'package:flutter/material.dart';
import 'constants.dart';


//Used in writing_stack for the GestureDetector
class WordPainter extends CustomPainter{
  List<List<Offset>> strokeList;
  List<Offset> offsetPoints= [];

  WordPainter({this.strokeList});

  @override
  void paint(Canvas canvas, Size size){
    final paintSettings = Paint()
      ..color= Colors.black
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    for (int i=0; i< strokeList.length; i++){
      for (int j=0; j< strokeList[i].length-1; j++){
        //draw endpoints
        canvas.drawPoints(
            PointMode.points,
            [strokeList[i].first, strokeList[i].last],
            paintSettings );
        //draw rest of stroke
        canvas.drawLine(strokeList[i][j], strokeList[i][j+1],paintSettings);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}



//Used in text_display
class ButtonRowBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){
    final paintSettings1 = Paint()
      ..color = kTextDisplayButtonRowBackgroundColor ;
    final paintSettings2 = Paint()
      ..blendMode = BlendMode.clear;

    Rect canvasRectangle = Rect.fromLTRB(0, 0, size.width, size.height);
    double h = size.height*1.3;
    Rect ovalRectangle = Rect.fromCenter(
        center: Offset(size.width/2,0),
        width: size.width,
        height: h);
    canvas.saveLayer(canvasRectangle, Paint());
    canvas.drawRect(canvasRectangle, paintSettings1);
    canvas.drawOval(ovalRectangle, paintSettings2);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}