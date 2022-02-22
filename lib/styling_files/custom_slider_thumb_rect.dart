
import 'dart:ui' as ui;//for image thumbslider
import 'package:flutter/material.dart';
import '../styling_files/constants.dart';

class CustomSliderThumbRect extends SliderComponentShape {
  double thumbRadius;
  double thumbHeight;
  double thumbWidth;
  int min;
  int max;
  // String text;
  ui.Image image;
  double scaleFactor;

  CustomSliderThumbRect({
    @required double this.thumbRadius,
    @required double this.thumbHeight,
    @required double this.thumbWidth,
    @required int this.min,
    @required int this.max,
    // @required String this.text,
    @required ui.Image this.image,
    @required double this.scaleFactor
  });


  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius * this.scaleFactor);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
        double textScaleFactor,
        Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;


    double imageWidth = image?.width.toDouble() ?? 10.0;
    double imageHeight = image?.height.toDouble() ?? 10.0;
    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2)
    ) * this.scaleFactor;

    imageWidth*=this.scaleFactor;
    imageHeight*= this.scaleFactor;



    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: thumbHeight*this.scaleFactor ,
        height: thumbWidth*this.scaleFactor
      ),
      Radius.circular(thumbRadius*this.scaleFactor),
    );



    final paint = Paint()
      ..color = sliderTheme.thumbColor //Thumb Background Color
      ..style = PaintingStyle.fill
      ..filterQuality = FilterQuality.high;

    final borderPaint = Paint()
      ..color = kBottomRightButtonsBorderColor
      ..strokeWidth = kBottomRightButtonsBorderWidth*this.scaleFactor
      ..style = PaintingStyle.stroke;
    //
    // TextSpan span = new TextSpan(
    //   style: new TextStyle(
    //       fontSize: thumbHeight * .3,
    //       fontWeight: FontWeight.w700,
    //       color: sliderTheme.thumbColor,
    //       height: 1),
    //   text: '${getValue(value)}');
    // TextPainter tp = new TextPainter(
    //     text: span,
    //     textAlign: TextAlign.left,
    //     textDirection: TextDirection.ltr);
    // tp.layout();
    // Offset textCenter =
    //   Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    canvas.drawRRect(rRect,borderPaint);
    // tp.paint(canvas, textCenter);





    // Draw the text:=----------------------
    // final textStyle = TextStyle(
    //   // color: kTsegSheTextColor,
    //   fontSize:25,
    // );
    // final textSpan = TextSpan(
    //   text: this.text ,
    //   style: textStyle,
    // );
    // final textPainter = TextPainter(
    //   text: textSpan,
    //   textDirection: TextDirection.ltr,
    // );
    // textPainter.layout(
    //     minWidth: 0,
    //     maxWidth: tp.width,// ../////////
    // );

    //Draw the image:_________________________________
    canvas.drawImage(image, imageOffset, paint);
  }

  String getValue(double value) {
    return (min+(max-min)*value).round().toString();
  }
}
