
import 'dart:ui' as ui;//for image thumbslider
import 'package:flutter/material.dart';

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final double thumbHeight;
  final int min;
  final int max;
  final String text;
  final ui.Image image;


  //
  // const CustomSliderThumbRect(double aThumbRadius, double aThumbHeight, int aMin, int aMax, [String aText]){
  //   this.thumbRadius=aThumbRadius;
  //   this.thumbHeight=aThumbHeight;
  //   this.min=aMin;
  //   this.max=aMax;
  //
  // };

  const CustomSliderThumbRect({this.thumbRadius,this.thumbHeight,this.min,this.max,this.text, this.image});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
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


    final imageWidth = image?.width ?? 10;
    final imageHeight = image?.height ?? 10;
    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2),
    );





    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.2, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );



    //
    // final imageWidth = image?.width ?? 10;
    // final imageHeight = image?.height ?? 10;
    // Offset imageOffset = Offset(
    //   center.dx - (imageWidth / 2),
    //   center.dy - (imageHeight / 2),
    // );
    //


    final paint = Paint()
      ..color = sliderTheme.activeTrackColor //Thumb Background Color
      ..style = PaintingStyle.fill
      ..filterQuality = FilterQuality.high;

    TextSpan span = new TextSpan(
        style: new TextStyle(         
            fontSize: thumbHeight * .3,
            fontWeight: FontWeight.w700,
            color: sliderTheme.thumbColor,
            height: 1),
        text: '${getValue(value)}');
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
    Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);





    // Draw the text:=----------------------
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize:25,
    );
    final textSpan = TextSpan(
      text: this.text ,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
        minWidth: 0,
        maxWidth: tp.width,// ../////////
    );
    final offset =    textCenter; // Offset(center.dx , center.dy );
    // if (this.text == "་།") {
    //   canvas.rotate(3.141592653 / 2);
    //   canvas.translate(0,90);
    // }
    textPainter.paint(canvas, offset);

    //Draw the image:_________________________________
    if (image != null) {
      canvas.drawImage(image, imageOffset, paint);
    }




  }

  String getValue(double value) {
    return (min+(max-min)*value).round().toString();
  }
}
//-------
