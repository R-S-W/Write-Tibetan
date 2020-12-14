import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'letter_suggestion_files/my_change_notifier_classes.dart';

import 'app_body_files/text_display.dart';
import 'app_body_files/suggestion_bar.dart';
import 'app_body_files/writing_stack.dart';
import 'styling_files/constants.dart';


class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start, //mainAxisSize: MainAxisSize.min,
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
            FlutterClipboard.copy(sug2Disp.getTextDisplaySentence());
          },
        ),

        SizedBox(
          height: 2.5,
          child: Container(
            color: kSuggestionBarBorderlineColor,
          )
        ),

        SuggestionBar(
          tappedLetterCallback: (str){
            //Display the word
            var sug2Disp =Provider.of<SuggestionToDisplay>(context) ;
            sug2Disp.addWord(str);
            //Clear the strokes+suggestions
            var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
            stroke2Sug.printPathListString();/////PRINT
            stroke2Sug.clearAll();//
          },
        ),


        SizedBox(
            height: 2.5,
            child: Container(
              color: kSuggestionBarBorderlineColor,
            )
        ),


        Consumer<StrokesToSuggestion>(
          builder: (context,stroke2Sug, child)=>
              WritingStack(
                strokeList: stroke2Sug.getStrokeList(),
          ),
        ),

        Expanded(
          child: Container(
            color: kBottomBarColor,
          )
        ),

      ],
    );
  }
}