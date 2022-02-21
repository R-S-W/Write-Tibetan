import 'package:flutter/material.dart';
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
    Size screenDims = MediaQuery.of(context).size;
    double sdm = screenDims.width / kDevScreenWidth;

    screenDims*= sdm;

    return Container(
      width: screenDims.width,
      height: screenDims.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : <Widget>[
          TextDisplay(),


          SizedBox(
            height: 3.5*sdm,
            width: screenDims.width,
            child: Container(
              color: kSuggestionBarBorderlineColor1,
            )
          ),


          SuggestionBar(),


          SizedBox(
            height: 3.5*sdm,
            width: screenDims.width,
            child: Container(
              color: kSuggestionBarBorderlineColor2,
            )
          ),


          WritingStack(),


          Expanded(
            child: Container(
              color: kBottomBarColor,
            )
          ),

        ],
      ),
    );
  }
}