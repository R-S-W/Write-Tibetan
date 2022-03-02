import 'package:flutter/material.dart';
import './styling_files/constants.dart';


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

    if (this.pageContents != null) {
      //List with Align widgets that have the text info
      List<Widget> pageTexts = <Widget>[];
      for (int i = 0; i< this.pageContents.length; i++){
        List contents = this.pageContents[i];
        pageTexts.add(
          Align(
            alignment: Alignment(contents[0],contents[1]),
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
          width: this.screenDims.width,
          height: this.screenDims.height,
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
