import 'package:flutter/material.dart';
import 'app_body_files/text_display.dart';
import 'app_body_files/suggestion_bar.dart';
import 'app_body_files/writing_stack.dart';
import 'package:provider/provider.dart';
import '../app_logic/app_brain.dart';
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
    var appBar = Provider.of<AppBrain>(context, listen:false);
    Size safeScreenDims = appBar.safeScreenDims;

    return Container(
      width: safeScreenDims.width,
      height: safeScreenDims.height - kTopBarHeight,
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


          // Expanded(
          //   // flex: 1,
          //   child: Container(
          //     color: kBottomBarColor,
          //   )
          // ),

        ],
      ),
    );
  }
}