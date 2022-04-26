import 'package:flutter/material.dart';

import '../../styling_files/constants.dart';
/*
  Displays the instructions to use the app.
  Takes data from info_screen_content.dart and the pagenumber from appBrain to
  build the correct info page.
 */

class InfoScreen extends StatelessWidget {
  final List<List> pageContents;
  final VoidCallback onPressed;
  final Size screenDims;
  final Size safeScreenDims;
  final double scaleFactor;

  InfoScreen( {
    @required this.pageContents,
    @required this.onPressed,
    @required this.screenDims,
    @required this.safeScreenDims,
    @required this.scaleFactor,
  } );

  @override
  Widget build(BuildContext context) {
    //Variable used to align y position of Text.
    double bottomWidgetsHeightRatio = (kTextDisplayButtonSize.height +
      kSuggestionBarHeight + 2*kTrimHeight + kWritingStackDim.dy)
      / (this.safeScreenDims.height - kInfoScreenTextStyle.fontSize - 4*0);
    /* Extra info:  the y position is aligned differently because the textDisplay
      screen is of a variable height, so when Align() uses relative positions,
      those positions will be incorrect for other screen dimensions.  The y
      position now must be in terms of bottomWidgetsHeightRatio to make sure
      the positions are accurate.
     */
    if (this.pageContents != null) {
      //List with Align widgets that have the text info
      List<Widget> pageTexts = <Widget>[];

      for (int i = 0; i< this.pageContents.length; i++){
        List contents = this.pageContents[i];
        pageTexts.add(
          Align(
            alignment:Alignment(contents[0],1-2*contents[1]*bottomWidgetsHeightRatio),
            child: Text(
              contents[2],
              textAlign: TextAlign.center,
              style: kInfoScreenTextStyle,
              textScaleFactor: this.scaleFactor
            )
          ),
        );
      }
      return TextButton(
        onPressed: this.onPressed,
        child: Container(
          color: kInfoScreenBackgroundColor,

          child: SafeArea(
            child: Container(
              width: this.safeScreenDims.width,
              height: this.safeScreenDims.height,
              child: Stack(
                children: pageTexts
              )
            )
          )
        ),
        style:TextButton.styleFrom(
          padding:EdgeInsets.zero,
          backgroundColor: kInfoScreenBackgroundColor,
          splashFactory: NoSplash.splashFactory
        )
      );
    }else{
      return Container();
    }
  }
}
