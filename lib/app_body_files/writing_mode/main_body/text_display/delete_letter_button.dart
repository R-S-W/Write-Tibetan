import 'dart:async';
import 'package:flutter/material.dart';
import '../../../styling_files/constants.dart';


/*Class for the delete button in the button row in the TextDisplay.  This button
  features a hold press voidCallback that has a variable press duration as
  opposed to the default 1 second for the onLongPress callback in regular
  buttons.
*/

class DeleteLetterButton extends StatefulWidget {
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  final double scaleFactor;


  DeleteLetterButton({Key key,
    @required this.onPressed,
    @required this.onLongPress,
    @required this.scaleFactor
  })
      :super(key: key);
  @override
  _DeleteLetterButtonState createState() => _DeleteLetterButtonState();
}

class _DeleteLetterButtonState extends State<DeleteLetterButton> {
  Timer _longPressTimer;
  final int _longPressDuration = 3000; //In milliseconds

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80*widget.scaleFactor,
      height: 60*widget.scaleFactor,
      child: GestureDetector(
        onTapDown: (_){
          _longPressTimer = Timer(
            Duration(milliseconds: _longPressDuration-500),
            widget.onLongPress
          );
        },
        onTapCancel: (){
          _longPressTimer.cancel();
        },
        child: ElevatedButton(
          child: Text(
            "Delete",
            style: kTextDisplayButtonTextStyle,
            softWrap: false,
            textAlign: TextAlign.center,
            textScaleFactor: widget.scaleFactor,
          ),
          onPressed: widget.onPressed,
          style:  ElevatedButton.styleFrom(
            primary: kCopyButtonColor,
            shape:RoundedRectangleBorder(
              borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(1.5 * kRoundedButtonRadius*widget.scaleFactor)
              ),
            ),
            padding: EdgeInsets.all(10*widget.scaleFactor)
          )
        ),
      ),
    );
  }
}
