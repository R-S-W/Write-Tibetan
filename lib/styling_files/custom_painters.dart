//CustomPainters


import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tibetan_handwriting_app_0_1/support_files/bezier_interpolation.dart';
import 'constants.dart';


//Used in writing_stack for the GestureDetector
class StrokePainter extends CustomPainter{
  List<List<Offset>> strokeList;
  List<Offset> offsetPoints= [];
  int maxBezPoints = 20; //Maximum number of points to interpolate with
  //BezierInterpolation class

  StrokePainter({this.strokeList});

  @override
  void paint(Canvas canvas, Size size){
    final paintSettings = Paint()
      ..color= Colors.red
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;

    final paintSettings2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;



    for (int i=0; i< strokeList.length; i++) {//For every stroke in strokeList,
      for (int j =0; j< strokeList[i].length-1; j++){
        canvas.drawLine(strokeList[i][j], strokeList[i][j+1], paintSettings);
      }


      // Path strokePath = Path(); //Stroke data
      // strokePath.moveTo(strokeList[i].first.dx, strokeList[i].first.dy);
      // int numInterpolations = (strokeList[i].length/maxBezPoints).ceil();
      //
      // //draw endpoints
      // canvas.drawPoints(
      //     PointMode.points,
      //     [strokeList[i].first, strokeList[i].last],
      //     paintSettings);
      //
      // // Break stroke into sections, interpolate each section with
      // // BezierInterpolation, and add the cubic interpolation function of that
      // // section to the strokePath.
      // for (int a= 1; a<=numInterpolations; a++){
      //   List<List<double>> strokeSlice = []; //Small portion of strokeList
      //   int sliceStart = (a-1)*maxBezPoints;
      //   int sliceEnd = min(sliceStart + maxBezPoints, strokeList.length);
      //   for (int jj = sliceStart; jj < sliceEnd; jj++) {
      //     strokeSlice.add([strokeList[i][jj].dx, strokeList[i][jj].dy]);
      //   }
      //   print('a: $a,  strokeSlice: ${strokeSlice.length}, $strokeSlice,   $numInterpolations,  #strokelist: ${strokeList.length}');
      //   if (strokeSlice.length < 3){// If portion too small for interpolation,
      //     for (int j=0; j< strokeSlice.length-1; j++){//Connect the points
      //       strokePath.lineTo(strokeList[i][j+1].dx,strokeList[i][j+1].dy);
      //     }
      //   }else{
      //     //interpolate strokeSlice
      //     BezierInterpolationND bezier = BezierInterpolationND(strokeSlice);
      //     List<List<Offset>> controlPoints = bezier.computeControlPointsND();
      //     // add interpolation to StrokePath
      //     for (int j = 0; j<strokeSlice.length; j++){
      //       strokePath.cubicTo(
      //           controlPoints[j][0].dx, controlPoints[j][1].dx,
      //           controlPoints[j][0].dy, controlPoints[j][1].dy,
      //           strokeList[i][j + 1].dx, strokeList[i][j + 1].dy
      //       );
      //     }
      //   }
      // }
      // canvas.drawPath(strokePath, paintSettings2);
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