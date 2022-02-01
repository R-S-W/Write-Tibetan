
import 'package:flutter/material.dart';
import '../styling_files/constants.dart';

class TextDisplayButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  BorderRadiusGeometry borderRadius;

  TextDisplayButton({
    key,
    @required this.onPressed,
    @required this.label,
    borderRadius
  }) : super(key: key){
    if (borderRadius == null){
      this.borderRadius = BorderRadius.vertical(
          top: Radius.circular(1.5 * kRoundedButtonRadius)
      );
    }else{
      this.borderRadius = borderRadius;
    }
  }

  TextDisplayButton.left({Key key, @required onPressed,@required label}) :
    this(
      key: key,
      onPressed: onPressed,
      label: label,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(1.5 * kRoundedButtonRadius)
      )
    );

  TextDisplayButton.right({Key key, @required onPressed,@required label}) :
    this(
      key: key,
      onPressed: onPressed,
      label: label,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(1.5 * kRoundedButtonRadius)
      )
    );

  TextDisplayButton.center({Key key, @required onPressed,@required label}) :
    this(key: key, onPressed: onPressed, label: label);




  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 60,
      child: ElevatedButton(
        child:Text(
          label,
          textAlign: TextAlign.center,
          style: kTextDisplayButtonTextStyle
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: kCopyButtonColor,
          shape:RoundedRectangleBorder(
            borderRadius: borderRadius,
          )
        )
      )
    );
    }
}


