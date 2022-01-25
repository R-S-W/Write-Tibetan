import 'dart:ui';
import 'package:flutter/material.dart';
import '../styling_files/constants.dart';


class BottomButton extends StatefulWidget {
  const BottomButton({
    Key key,
    @required this.onPressed,
    @required this.label,
    @required this.color
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final Color color;

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: kEnterButtonDim.dx,
      height:kEnterButtonDim.dy,
      child:  ElevatedButton(
        child: Align(
          alignment:Alignment(0,-.25),
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: kShipporiAntiqueB1,
              fontSize:22.0,
              color: kButtonTextColor,
              letterSpacing: -.5,
            ),
          ),
        ),
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          primary: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(kRoundedButtonRadius)),
            side:BorderSide(
              color: kBottomRightButtonsBorderColor,
              width:kBottomRightButtonsBorderWidth
            )
          ),
        ),
      )
    );
  }
}
