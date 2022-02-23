
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

    print('center orig ::: $center');

    //image is already scaled by scalefactor in TsegShe
    Offset imageDims = Offset(image.width.toDouble(), image.height.toDouble());

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

    //Draw the image:_________________________________
    canvas.drawImage(image, imageOffset, paint);
  }
}
