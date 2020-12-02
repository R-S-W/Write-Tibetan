
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'MyChangeNotifierClasses.dart';

// import 'main.dart';//!hope this is okay too
// import 'MainBody.dart';




class TextDisplay extends StatefulWidget {
  // TextDisplay({Key key}) : super(key: key);
  // TextDisplay( this.clearSentenceCallback, this.deleteWordCallback);
  // String Sentence;
  final VoidCallback deleteWordCallback;
  final VoidCallback clearSentenceCallback;
  final VoidCallback copyTextCallback;

  // TextDisplay({@required this.Sentence, @required this.timerUpdateCallback});    changed to down below because maybe keys will help updating things
  TextDisplay({Key key, @required this.deleteWordCallback, @required this.clearSentenceCallback, @required this.copyTextCallback}):super(key: key);  ///

  @override
  _TextDisplayState createState() => _TextDisplayState();
}

class _TextDisplayState extends State<TextDisplay> {
  @override


  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          Container(
            width: 414,
            height: 350,
            color: Colors.white,
            child:  Consumer<SuggestionToDisplay>(
            builder: (context,sentenceStr, child)=>SelectableText(
              sentenceStr.TextDisplaySentence,
              style: new TextStyle(fontSize: 50),
              showCursor: true,


              // // sentenceStr.TextDisplaySentence,
              // // style: new TextStyle(fontSize: 50),
              // showCursor: true,
              // readOnly: true,
              // // selectionEnabled: true,




              ),
            ),
          ),
          Container(
            width: 80,
            height: 60,
            color: Colors.lightBlue,
            child: RaisedButton(
              onPressed: widget.deleteWordCallback,
              onLongPress: widget.clearSentenceCallback
            ),
          ),

          Positioned(
            bottom: 290,
            child: Container(
              width: 80,
              height: 60,
              color: Colors.green,
              child: RaisedButton(
                onPressed: widget.copyTextCallback
              )
            ),
          )
        ]
    );
  }
}
