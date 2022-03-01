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
            // color: Colors.blue
        ),
        style:TextButton.styleFrom(
          padding:EdgeInsets.zero,
          backgroundColor: Color(0x3B000000)
        )
      );
    }else{
      return Container();
    }
  }
}
