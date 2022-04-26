import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tibetan_handwriting_app_0_1/practice_mode/practice_character_page.dart';
import 'package:tibetan_handwriting_app_0_1/practice_mode/practice_mode.dart';
<<<<<<< HEAD:lib/app_body_files/main.dart
import 'package:tibetan_handwriting_app_0_1/app_body_files/start_screen.dart';
import 'package:tibetan_handwriting_app_0_1/writing_mode/writing_mode.dart';

import 'frame.dart';
import '../styling_files/constants.dart';
=======
import 'package:tibetan_handwriting_app_0_1/start_screen.dart';
import 'package:tibetan_handwriting_app_0_1/writing_mode/writing_mode.dart';

import 'frame.dart';
import 'styling_files/constants.dart';
>>>>>>> 5b05839b042da42562c3cf4c792468202f95b23c:lib/main.dart


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
    // Size screenDimensions = MediaQuery.of(context).size;
    // EdgeInsets padding = MediaQuery.of(context).padding;
    //
    // //Screen dimensions multiplier
    // double safeScreenWidth = screenDimensions.width-padding.left -padding.right;
    // double safeScreenHeight= screenDimensions.height-padding.top-padding.bottom;
    // double sdm = safeScreenWidth / kDevScreenWidth;
    // screenDimensions*=sdm;

    //Generate routes for different pages for navigator
    Map <String, Widget Function(BuildContext)>navigatorRoutes = {
      '/':(context) => Frame(child: StartScreen()),
      '/writing' : (context) => Frame(child: WritingMode()),
      '/practice' : (context) => Frame(child: PracticeMode()),
    };
    for (int i = 0; i< kAlphabet.length; i++){
      navigatorRoutes['/' + kAlphabet[i]] =
        (context) => Frame(child: PracticeCharacterPage(kAlphabet[i]));
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