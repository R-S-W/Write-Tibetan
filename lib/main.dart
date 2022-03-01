import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'app_logic/app_brain.dart';
import 'main_body.dart';
import 'styling_files/constants.dart';


void main() {
  runApp(
      MyApp()
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(//Set to portrait orientation
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: kMyAppThemeData,
      home: MainPage(),// this was done to use navigator
    );
  }
}



class MainPage extends StatelessWidget {
  const MainPage({
    Key key,
  }) : super(key: key);

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
        // child: SafeArea(
          child: Container(
            // width: screenDimensions.width,
            // height: screenDimensions.height,
            // width: safeScreenWidth,
            // height: safeScreenHeight,
            child: ChangeNotifierProvider(
              create:(context) => AppBrain(
                  screenDims: screenDimensions,
                  safeScreenDims: Size(safeScreenWidth, safeScreenHeight),
                  safePadding: padding
              ),

              child: MainBody()
            ),
          ),
        ),
      );
    // );
  }
}