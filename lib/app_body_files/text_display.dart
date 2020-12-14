
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
            width: 414,
            height: 350,
            color: kTextDisplayColor,
            child:  Consumer<SuggestionToDisplay>(
              builder: (context,sentenceStr, child)=>SelectableText(
                sentenceStr.getTextDisplaySentence(),
                style: kTextDisplayStyle,
                showCursor: true,
                // autofocus: true,     does work, but always at the front.

              ),
            ),
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
                    onPressed: widget.copyTextCallback
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
                  onLongPress: widget.clearSentenceCallback,

                ),
              ),

            ]
          ),

        ]
    );
  }
}
