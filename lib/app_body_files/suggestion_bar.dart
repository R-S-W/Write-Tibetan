

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_logic/app_brain.dart';
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
      child:  Consumer<AppBrain>(
        builder: (context,appBrain, child)=> ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: appBrain.suggestions.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              width: kSuggestionListViewWidgetDim.dx,
              height: kSuggestionListViewWidgetDim.dy,
              color: kSuggestionBarColor,

              padding: const EdgeInsets.all(5.0) ,
              child: ListTile(
                title: Stack(
                  children: <Widget>[
                    Text(appBrain.suggestions[index],
                      style: kSuggestionTextStyle.copyWith(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.9
                          ..color = Color(0xa0000000)
                      )
                    ),

                    Text(appBrain.suggestions[index],
                      style: kSuggestionTextStyle.copyWith(
                      ),
                    ),
                  ]
                ),

                onTap: () {
                  widget.tappedLetterCallback( appBrain.suggestions[index],);
                }
              ),
            );
          }
        ),
      )
    );
  }
}