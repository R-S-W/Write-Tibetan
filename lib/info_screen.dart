import 'package:flutter/material.dart';
import './styling_files/constants.dart';


class InfoScreen extends StatelessWidget {
  final bool isVisible;
  final VoidCallback toggleVisibility;

  InfoScreen({@required this.isVisible, @required this.toggleVisibility});

  @override
  Widget build(BuildContext context) {
    if (this.isVisible) {
      return TextButton(
        onPressed: this.toggleVisibility,
        child: Container(
        ),
        style:TextButton.styleFrom(
          padding:EdgeInsets.zero,
          backgroundColor: kInfoScreenBackgroundColor,
          primary: Colors.transparent,
          splashFactory: NoSplash.splashFactory
        )
      );
    }else{
      return Container();
    }
  }
}
