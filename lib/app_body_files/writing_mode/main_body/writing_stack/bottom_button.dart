import 'package:flutter/material.dart';
import '../../../styling_files/constants.dart';


class BottomButton extends StatefulWidget {
  const BottomButton({
    Key key,
    @required this.onPressed,
    @required this.label,
    @required this.color,
    @required this.scaleFactor
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final Color color;
  final double scaleFactor;

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: kEnterButtonDim.dx*widget.scaleFactor,
      height:kEnterButtonDim.dy*widget.scaleFactor,
      child:  ElevatedButton(
        child: Align(
          alignment:Alignment(0,-.25),
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: kShipporiAntiqueB1,
              fontSize:22.0,
              color: kButtonTextColor,
              letterSpacing: -.5*widget.scaleFactor,
            ),
            textScaleFactor: widget.scaleFactor,
          ),
        ),
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          primary: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(kRoundedButtonRadius*widget.scaleFactor)),
            side:BorderSide(
              color: kBottomRightButtonsBorderColor,
              width:kBottomRightButtonsBorderWidth*widget.scaleFactor
            )
          ),
          padding:EdgeInsets.all(0)
        ),
      )
    );
  }
}
