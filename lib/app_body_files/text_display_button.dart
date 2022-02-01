//Widgets used for the buttons on the TextDisplay, (copy all, delete, etc.)
import 'package:flutter/material.dart';
import '../styling_files/constants.dart';

class TextDisplayButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  //Used to determine the shape of the top of the buttons
  final List<BorderRadiusGeometry> borderList = [
    BorderRadius.only( topRight: Radius.circular(1.5 * kRoundedButtonRadius) ),
    BorderRadius.vertical( top: Radius.circular(1.5 * kRoundedButtonRadius) ),
    BorderRadius.only( topLeft: Radius.circular(1.5 * kRoundedButtonRadius) )
  ];
  final int borderRadiusIdx;

  TextDisplayButton({
    key,
    @required this.onPressed,
    @required this.label,
    this.borderRadiusIdx = 1
  }) : super(key: key);

  //Used as a style for leftmost button on the row of TextDisplayButtons
  TextDisplayButton.left({Key key, @required onPressed,@required label}) :
    this(
      key: key,
      onPressed: onPressed,
      label: label,
      borderRadiusIdx: 0
    );

  //Used as a style for rightmost button on the row of buttons in TextDisplay
  TextDisplayButton.right({Key key, @required onPressed,@required label}) :
    this(
      key: key,
      onPressed: onPressed,
      label: label,
      borderRadiusIdx: 2
    );



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
            borderRadius: this.borderList[
              (0<=this.borderRadiusIdx && this.borderRadiusIdx <3) ?
              this.borderRadiusIdx :
              1
            ],
          )
        )
      )
    );
    }
}


