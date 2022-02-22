//Widgets used for the buttons on the TextDisplay, (copy all, delete, etc.)
import 'package:flutter/material.dart';
import '../styling_files/constants.dart';

class TextDisplayButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double scaleFactor;
  //Used to determine the shape of the top of the buttons
  List<BorderRadiusGeometry> borderList;
  final int borderRadiusIdx;

  TextDisplayButton({
    key,
    @required this.onPressed,
    @required this.label,
    @required this.scaleFactor,
    this.borderRadiusIdx = 1
  }){
    this.borderList = [
      BorderRadius.only( topRight: Radius.circular(this.scaleFactor*kRoundedButtonRadius) ),
      BorderRadius.vertical( top: Radius.circular(this.scaleFactor*kRoundedButtonRadius) ),
      BorderRadius.only( topLeft: Radius.circular(this.scaleFactor*kRoundedButtonRadius) )
    ];
  }


  //Used as a style for leftmost button on the row of TextDisplayButtons
  TextDisplayButton.left({
    Key key,
    @required onPressed,
    @required label,
    @required scaleFactor
  }) :
    this(
      key: key,
      onPressed: onPressed,
      label: label,
      scaleFactor: scaleFactor,
      borderRadiusIdx: 0
    );

  //Used as a style for rightmost button on the row of buttons in TextDisplay
  TextDisplayButton.right({
    Key key,
    @required onPressed,
    @required label,
    @required scaleFactor
  }) :
    this(
      key: key,
      onPressed: onPressed,
      label: label,
      scaleFactor: scaleFactor,
      borderRadiusIdx: 2
    );



  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80*this.scaleFactor,
      height: 60*this.scaleFactor,
      child: ElevatedButton(
        child:Text(
          label,
          textAlign: TextAlign.center,
          style: kTextDisplayButtonTextStyle,
          textScaleFactor: this.scaleFactor,
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: kCopyButtonColor,
          shape:RoundedRectangleBorder(
            borderRadius: this.borderList[
              (0<=this.borderRadiusIdx && this.borderRadiusIdx <3) ?
              this.borderRadiusIdx :
              1
            ],
          ),
          padding: EdgeInsets.all(10*this.scaleFactor)
        )
      )
    );
    }
}


