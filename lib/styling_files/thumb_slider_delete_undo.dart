import 'package:flutter/material.dart';



class ThumbSliderDeleteUndo extends SliderComponentShape {
  final double thumbRadius;
  final double thumbHeight;
  final int min;
  final int max;
  final String text;


  const ThumbSliderDeleteUndo({
    this.thumbRadius,
    this.thumbHeight,
    this.min,this.max,
    this.text
  });

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


    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.2, height: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );



    final paint = Paint()
      ..color = sliderTheme.activeTrackColor //Thumb Background Color
      ..style = PaintingStyle.fill;

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
    Offset textCenter = Offset(center.dx, center.dy);

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
      maxWidth: tp.width
    );
    final offset =    textCenter;
    textPainter.paint(canvas, offset);
  }

  String getValue(double value) {
    return (min+(max-min)*value).round().toString();
  }
}
