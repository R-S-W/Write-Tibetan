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
            var appBrain =Provider.of<AppBrain>(context) ;
            appBrain.clearSentence();
          },
          deleteWordCallback: (){
            var appBrain =Provider.of<AppBrain>(context) ;
            appBrain.deleteWord();
          },
          copyTextCallback: (){
            var appBrain = Provider.of<AppBrain>(context);
            FlutterClipboard.copy(appBrain.getTextDisplaySentence());
          },
        ),

        SizedBox(
          height: 3.5,
          child: Container(
            color: kSuggestionBarBorderlineColor1,
          )
        ),

        SuggestionBar(
          tappedLetterCallback: (str){
            //Display the word
            var appBrain =Provider.of<AppBrain>(context) ;
            appBrain.addWord(str);
            //Clear the strokes+suggestions
            appBrain.printPathListString();/////PRINT
            appBrain.clearAllStrokesAndSuggestions();//
          },
        ),


        SizedBox(
            height: 3.5,
            child: Container(
              color: kSuggestionBarBorderlineColor2,
            )
        ),


        Consumer<AppBrain>(
          builder: (context,appBrain, child)=>
              WritingStack(
                strokeList: appBrain.getStrokeList(),
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