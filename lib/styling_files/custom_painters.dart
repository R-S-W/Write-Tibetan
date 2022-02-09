//CustomPainters


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tibetan_handwriting_app_0_1/support_files/bezier_interpolation.dart';
import 'constants.dart';


//Used in writing_stack for the GestureDetector
class StrokePainter extends CustomPainter{
  List<List<Offset>> strokeList;
  List<Offset> offsetPoints= [];

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

    for (int i=0; i< strokeList.length; i++) {

      if (strokeList[i].length <= 2) {
        for (int j = 0; j < strokeList[i].length - 1; j++) {
          canvas.drawLine(strokeList[i][j], strokeList[i][j + 1], paintSettings);
        }
      }else{
        Path strokePath = Path();
        strokePath.moveTo(strokeList[i].first.dx, strokeList[i].first.dy);
        List<List<double>> dataPoints = [];
        for (int jj = 0; jj < strokeList[i].length; jj++) {
          dataPoints.add([strokeList[i][jj].dx, strokeList[i][jj].dy]);
        }

        // print('datapoints: $dataPoints');
        BezierInterpolationND bezier = BezierInterpolationND(dataPoints);
        List<List<Offset>> controlPoints = bezier.computeControlPointsND();

        // for(int a=0; a< strokeList[i].length; a++){
        //   print('Pos: ${strokeList[i][a]} | Control: ${controlPoints[i][0]} , ${controlPoints[i][1]}');
        // }
        // print('\n\n');


        //draw endpoints
        canvas.drawPoints(
            PointMode.points,
            [strokeList[i].first, strokeList[i].last],
            paintSettings);

        for (int j = 0; j < strokeList[i].length - 1; j++) {

          //draw rest of stroke
          // canvas.drawLine(strokeList[i][j], strokeList[i][j+1],paintSettings);

          strokePath.cubicTo(
              controlPoints[j][0].dx, controlPoints[j][1].dx,
              controlPoints[j][0].dy, controlPoints[j][1].dy,
              strokeList[i][j + 1].dx, strokeList[i][j + 1].dy
          );
          canvas.drawPoints(
              PointMode.points,
              [strokeList[i][j], strokeList[i][j+1]],
              paintSettings);

          // strokePath.lineTo(strokeList[i][j+1].dx, strokeList[i][j+1].dy);

        }

        canvas.drawPath(strokePath, paintSettings2);
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