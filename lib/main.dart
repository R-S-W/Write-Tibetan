import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:tibetan_handwriting_app_0_1/practice_letter_page.dart';
import 'package:tibetan_handwriting_app_0_1/practice_mode.dart';
import 'package:tibetan_handwriting_app_0_1/start_screen.dart';
import 'package:tibetan_handwriting_app_0_1/writing_mode.dart';

import 'app_logic/app_brain.dart';
import 'frame.dart';
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

    //Generate routes for different pages for navigator
    Map navigatorRoutes = {
      '/':(context) => Frame(child: StartScreen()),
      '/writing' : (context) => Frame(child: WritingMode()),
      '/practice' : (context) => Frame(child: PracticeMode()),
    };
    for (int i = 0; i< kAlphabet.length; i++){
      navigatorRoutes.update(
        '/'+kAlphabet[i],
        (context) => Frame(child: PracticeCharacterPage(kAlphabet[i]))
      );
    }



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
          child: MaterialApp(
            title: 'Select Mode:',
            initialRoute:'/',
            routes: navigatorRoutes
          ),
        ),
      );
    // );
  }
}