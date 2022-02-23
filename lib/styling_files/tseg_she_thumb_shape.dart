
import 'dart:ui' as ui;//for image thumbslider
import 'package:flutter/material.dart';
import '../styling_files/constants.dart';

class TsegSheThumbShape extends SliderComponentShape {
  double thumbRadius;
  double thumbHeight;
  double thumbWidth;
  int min;
  int max;
  ui.Image image;
  double scaleFactor;

  TsegSheThumbShape({
    @required this.thumbRadius,
    @required this.thumbHeight,
    @required this.thumbWidth,
    @required this.min,
    @required this.max,
    @required this.image,
    @required this.scaleFactor
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
    //image and center are already scaled by scalefactor in TsegShe, they do not
    // need to be modified.
    final imageWidth = image?.width ?? 10;
    final imageHeight = image?.height ?? 10;
    Offset imageDims = Offset(imageWidth.toDouble(), imageHeight.toDouble());
    Offset imageOffset = center - imageDims/2;

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

    canvas.drawRRect(rRect, paint);
    canvas.drawRRect(rRect,borderPaint);
    if (image != null){
      canvas.drawImage(image, imageOffset, paint);
    }
  }
}
