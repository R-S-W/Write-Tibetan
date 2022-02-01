import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_logic/app_brain.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children : <Widget>[
        TextDisplay(),

        SizedBox(
          height: 3.5,
          child: Container(
            color: kSuggestionBarBorderlineColor1,
          )
        ),

        SuggestionBar(
          tappedLetterCallback: (str){
            //Display the word
            var appBrain =Provider.of<AppBrain>(context, listen:false) ;
            appBrain.addWord(str);
            //Clear the strokes+suggestions
            appBrain.printPathListString();/////PRINT
            appBrain.clearAllStrokesAndSuggestions();
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