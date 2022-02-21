import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'app_logic/app_brain.dart';
import 'main_body.dart';
import 'info_page.dart';
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

    //Screen dimensions multiplier
    double sdm = screenDimensions.width / kDevScreenWidth;
    screenDimensions*=sdm;

    return Scaffold(
        body: Container(
          width: screenDimensions.width,
          height: screenDimensions.height,
          child: Column(
            children: <Widget>[
              Container(//Top bar
                color: kAppBarBackgroundColor,
                child: Row(
                  children:[
                    Text(
                      'Tibetan Handwritten Input Method',
                      style: TextStyle(
                        fontFamily:kMohave,
                        fontSize:26 * sdm,
                        color: kTWhite
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info_outline,
                        size: 24*sdm
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> InfoPage())
                        );
                      }
                    ),
                  ]
                ),
              ),
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create:(context) => AppBrain(screenDims: screenDimensions)
                  ),
                ],
                child:MainBody()
              ),
            ],
          ),
      )
    );
  }
}