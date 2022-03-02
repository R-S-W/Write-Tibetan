import 'package:flutter/material.dart';
import './styling_files/constants.dart';


class InfoScreen extends StatelessWidget {
  final bool isVisible;
  final VoidCallback toggleVisibility;
  final Size screenDims;
  final Size safeScreenDims;

  InfoScreen( {
    @required this.isVisible,
    @required this.toggleVisibility,
    @required this.screenDims,
    @required this.safeScreenDims
  } );

  @override
  Widget build(BuildContext context) {
    if (this.isVisible) {
      return TextButton(
        onPressed: this.toggleVisibility,
        child: Container(
          width: this.screenDims.width,
          height: this.screenDims.height,
          color: kInfoScreenBackgroundColor,

          child: SafeArea(
            child: Container(
              width: this.safeScreenDims.width,
              height: this.safeScreenDims.height,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment(0,-.5),
                    child: Text(
                      'Select and copy text here',
                      textAlign: TextAlign.center,
                      style: kInfoScreenTextStyle
                    )
                  ),
                  Align(
                    child: Text(
                      'Choose suggested characters here',
                      textAlign: TextAlign.center,
                      style: kInfoScreenTextStyle
                    ),
                    alignment: Alignment(0,.15)

                  ),
                  Align(
                    child: Text(
                      'Draw letters here',
                      textAlign: TextAlign.center,
                      style: kInfoScreenTextStyle
                    ),
                    alignment: Alignment(0,.65),
                  ),
                  // Align(
                  //   alignment: Alignment(0,.95),
                  //   child: Text(
                  //     '888',
                  //     textAlign: TextAlign.center,
                  //     style: kInfoScreenTextStyle
                  //   ),
                  // )
                ]
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
