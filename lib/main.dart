import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_body_files/frame.dart';
import 'app_body_files/practice_mode/practice_character_page.dart';
import 'app_body_files/practice_mode/practice_mode.dart';
import 'app_body_files/start_screen.dart';
import 'app_body_files/writing_mode/writing_mode.dart';
import 'app_logic/app_brain.dart';
import 'styling_files/constants.dart';
import 'package:provider/provider.dart';



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



class MainPage extends StatefulWidget {
  const MainPage({
    Key key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Size screenDimensions = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    // //Screen dimensions multiplier
    double safeScreenWidth = screenDimensions.width-padding.left -padding.right;
    double safeScreenHeight= screenDimensions.height-padding.top-padding.bottom;

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

    return ChangeNotifierProvider(
      create:(context) => AppBrain(
          screenDims: screenDimensions,
          safeScreenDims: Size(safeScreenWidth, safeScreenHeight),
          safePadding: padding
      ),
      child: Scaffold(
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
      )
    );
  }
}