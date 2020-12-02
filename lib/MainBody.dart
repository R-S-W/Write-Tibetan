import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
// import 'dart:async';

import 'TextDisplay.dart';
import 'SuggestionBar.dart';
import 'WritingStack.dart';

import 'package:provider/provider.dart';
import 'MyChangeNotifierClasses.dart';

// import 'main.dart'; //////!hope this is okay



class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {


  List<List<Offset>> _StrokeList = List();
  List<List<String>> _LetterList = List.filled(0, <String>[]);
  List<String> _Letter = <String>[];
  String _Sentence = "{{";





  @override
  Widget build(BuildContext context) {
    // _startTimer();
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start, // mainAxisSize: MainAxisSize.min,
      children : <Widget>[
        TextDisplay(
          clearSentenceCallback:(){
            var sug2Disp =Provider.of<SuggestionToDisplay>(context) ;
            sug2Disp.clearSentence();
          },
          deleteWordCallback: (){
            var sug2Disp =Provider.of<SuggestionToDisplay>(context) ;
            sug2Disp.deleteWord();
          },
          copyTextCallback: (){
            var sug2Disp = Provider.of<SuggestionToDisplay>(context);
            FlutterClipboard.copy(sug2Disp.TextDisplaySentence);
          },
        ),


         SuggestionBar(
          Suggestions: [], //    temporary
          tappedLetterCallback: (str){
            var sug2Disp =Provider.of<SuggestionToDisplay>(context) ;//Display the word
            sug2Disp.addWord(str);

            var stroke2Sug = Provider.of<StrokesToSuggestion>(context);//Clear the strokes+suggestions

            stroke2Sug.printPathListString();

            stroke2Sug.clearAll();//

          },
         ),


        Consumer<StrokesToSuggestion>(
          builder: (context,stroke2Sug, child)=> WritingStack(
            StrokeList: stroke2Sug.StrokeList,
            // strokeDetectCallback: (aStroke) {
            //   var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
            //   stroke2Sug.addStroke(aStroke);
            // },

          ),
        ),
      ],
    );
  }
}
