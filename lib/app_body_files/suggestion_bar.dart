

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_logic/app_brain.dart';
import '../styling_files/constants.dart';


class SuggestionBar extends StatefulWidget {
  @override
  _SuggestionBarState createState() => _SuggestionBarState();
}

class _SuggestionBarState extends State<SuggestionBar> {
  @override
  Widget build(BuildContext context){
    Size screenDims = MediaQuery.of(context).size;
    //sdm = Screen Dimensions Multiplier
    double sdm = screenDims.width/kDevScreenWidth;


    return Container(
      height: kSuggestionBarHeight * sdm,
      width: screenDims.width,
      decoration: BoxDecoration(
        color: kSuggestionBarColor,
      ),
      child:  Consumer<AppBrain>(
        builder: (context,appBrain, child)=> ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: appBrain.suggestions.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              width: kSuggestionListViewWidgetDim.dx * sdm,
              height: kSuggestionListViewWidgetDim.dy * sdm,
              color: kSuggestionBarColor,
              child: TextButton(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Text(appBrain.suggestions[index],
                        style: kSuggestionTextStyle.copyWith(
                          foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1.9*sdm
                          ..color = Color(0xa0000000)
                        ),
                        textScaleFactor: sdm,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Positioned.fill(
                      child: Text(appBrain.suggestions[index],
                        style: kSuggestionTextStyle,
                        textScaleFactor: sdm,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  appBrain.addWord(appBrain.suggestions[index]);
                  //Clear the strokes+suggestions
                  appBrain.printPathListString();/////PRINT
                  appBrain.clearAllStrokesAndSuggestions();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(9*sdm),
                )
              ),
            );
          }
        ),
      )
    );
  }
}