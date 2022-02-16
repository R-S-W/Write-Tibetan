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

  StrokePainter({@required this.strokeList});

  @override
  void paint(Canvas canvas, Size size){
    final endpointPaintSettings = Paint()
      ..color= kBrushColor
      ..isAntiAlias = true
      ..strokeWidth = kBrushSize
      ..strokeCap = StrokeCap.round;

    final curvePaintSettings = Paint()
      ..color = kBrushColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = kBrushSize;


    for (int i=0; i< strokeList.length; i++) {//For every stroke in strokeList,
      Path strokePath = Path(); //Class used to paint canvas
      strokePath.moveTo(strokeList[i].first.dx, strokeList[i].first.dy);
      int numInterpolations = (strokeList[i].length/maxBezPoints).ceil();

      //draw endpoints
      canvas.drawPoints(
        PointMode.points,
        [strokeList[i].first, strokeList[i].last],
        endpointPaintSettings);

      // Break stroke into sections,
      // interpolate each section with BezierInterpolation, and
      // add the cubic interpolation function of that section to the strokePath.
      for (int a= 1; a<=numInterpolations; a++){
        List<List<double>> strokeSlice = []; //Small portion of strokeList
        int sliceStart = (a-1)*maxBezPoints;
        int sliceEnd = min(sliceStart + maxBezPoints, strokeList[i].length);
        for (int jj = sliceStart; jj < sliceEnd; jj++) {
          strokeSlice.add([strokeList[i][jj].dx, strokeList[i][jj].dy]);
        }

        if (a>1){ //If the full stroke is segmented into multiple slices,
          // draw a line from previous stroke slice to current stroke slice
          strokePath.lineTo(strokeSlice.first[0], strokeSlice.first[1]);
        }

        if (strokeSlice.length < 3){// If portion too small for interpolation,
          for (int j=1; j< strokeSlice.length; j++){//Connect the points
            strokePath.lineTo(strokeSlice[j][0],strokeSlice[j][1]);
          }
        }else{
          //interpolate strokeSlice
          BezierInterpolationND bezier = BezierInterpolationND(strokeSlice);
          List<List<Offset>> controlPoints = bezier.computeControlPointsND();
          // add interpolation to StrokePath
          for (int j = 0; j<strokeSlice.length-1; j++){
            strokePath.cubicTo(
              controlPoints[j][0].dx, controlPoints[j][1].dx,
              controlPoints[j][0].dy, controlPoints[j][1].dy,
              strokeSlice[j+1][0], strokeSlice[j+1][1]
            );
          }
        }
      }
      canvas.drawPath(strokePath, curvePaintSettings);
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