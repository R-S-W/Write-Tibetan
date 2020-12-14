

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../letter_suggestion_files/my_change_notifier_classes.dart';
import '../styling_files/constants.dart';


class SuggestionBar extends StatefulWidget {
  SuggestionBar({ @required this.tappedLetterCallback});
  final List<String> suggestions= [];
  final Function(String)  tappedLetterCallback; // no final on this voidcallback

  @override
  _SuggestionBarState createState() => _SuggestionBarState();
}

class _SuggestionBarState extends State<SuggestionBar> {
  @override
  Widget build(BuildContext context){
    return Container(

      height: kSuggestionBarHeight,
      decoration: BoxDecoration(
        color: kSuggestionBarColor,

      ),
      child:  Consumer<StrokesToSuggestion>(
        builder: (context,stroke2Sug, child)=> ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stroke2Sug.getSuggestionsLength(),
          itemBuilder: (BuildContext context, int index){
            return Container(
              width: kSuggestionListViewWidgetDim.dx,
              height: kSuggestionListViewWidgetDim.dy,
              color: kSuggestionBarColor,

              padding: const EdgeInsets.all(5.0) ,
              child: ListTile(
                title: Stack(
                  children: <Widget>[  //(order Matters)


                    Text(stroke2Sug.getSuggestionAt(index),
                      style: kSuggestionTextStyle.copyWith(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.9
                          ..color = Color(0xa0000000)


                      )
                    ),

                    Text(stroke2Sug.getSuggestionAt(index),
                      style: kSuggestionTextStyle.copyWith(
                      ),
                    ),


                  ]
                ),




                // Text(stroke2Sug.getSuggestionAt(index),
                //   style: kSuggestionTextStyle,
                // ),

                onTap: () {
                  widget.tappedLetterCallback( stroke2Sug.getSuggestionAt(index),);
                }
              ),
            );
          }
        ),
      )
    );
  }
}