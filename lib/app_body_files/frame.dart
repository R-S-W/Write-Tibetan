import 'package:flutter/material.dart';
import '../styling_files/constants.dart';


class Frame extends StatefulWidget {
  Widget child;
  Frame({ @required Widget this.child, Key key
  }) : super(key: key);

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  @override
  Widget build(BuildContext context) {
    Size screenDimensions = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;

    //Screen dimensions multiplier
    double safeScreenWidth = screenDimensions.width-padding.left -padding.right;
    double safeScreenHeight= screenDimensions.height-padding.top-padding.bottom;
    double sdm = safeScreenWidth / kDevScreenWidth;
    screenDimensions*=sdm;

    return Scaffold(
      backgroundColor: kAppBarBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kAppBarBackgroundColor, kBottomBarColor],
            stops: [0.5, 0.5],
          ),
        ),
        child: widget.child
      ),
    );
    // );
  }
}