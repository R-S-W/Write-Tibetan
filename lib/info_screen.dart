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
              // color: Colors.red
              child: Column(children: <Widget>[
                Container(width: 50, height: 50, color: Colors.red)]
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
