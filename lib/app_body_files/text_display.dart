
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../letter_suggestion_files/my_change_notifier_classes.dart';
import '../styling_files/constants.dart';


class TextDisplay extends StatefulWidget {
  TextDisplay({Key key, @required this.deleteWordCallback,
    @required this.clearSentenceCallback,
    @required this.copyTextCallback}):super(key: key);

  final VoidCallback deleteWordCallback;
  final VoidCallback clearSentenceCallback;
  final VoidCallback copyTextCallback;
  @override
  _TextDisplayState createState() => _TextDisplayState();
}

class _TextDisplayState extends State<TextDisplay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(//Display
            padding: EdgeInsets.only(left: kTextMargin),
            width: 414,
            height: 350,
            color: kTextDisplayColor,
            child:  Consumer<AppBrain>(
              builder: (context,appBrain, child)=> TextField(
                controller: appBrain.textDisplayController,

                readOnly: true,
                showCursor: true,
                maxLines: null,
                decoration: null, //InputDecoration(),
                cursorColor: Colors.red,
                style: TextStyle(
                  fontSize: kTextFontSize,
                )
              ),
            ),


            // Consumer<AppBrain>(
            //   builder: (context,appBrain, child)=>SelectableText(
            //     appBrain.getTextDisplaySentence(),
            //     style: kTextDisplayStyle,
            //     showCursor: true,
            //     // autofocus: true,     does work, but always at the front.
            //   ),
            // ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 80,
                height: 60,
                child: RaisedButton(
                  color: kDeleteButtonColor,
                  child:Text(
                    "Copy\nAll",
                    textAlign: TextAlign.center,
                    // style: kTextDisplayButtonStyle,
                  ),
                  onPressed: widget.copyTextCallback,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular( 1.5*kRoundedButtonRadius)),
                  ),
                )
              ),

              Container( //DeleteButton
                width: 80,
                height: 60,
                child: RaisedButton(
                  color: kCopyButtonColor,
                  child: Text(
                    "Del"
                  ),
                  onPressed: widget.deleteWordCallback,
                  onLongPress: widget.deleteWordCallback,//widget.clearSentenceCallback,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular( 1.5*kRoundedButtonRadius)),
                  ),

                ),
              ),

            ]
          ),

        ]
    );
  }
}
