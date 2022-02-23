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
    EdgeInsets padding = MediaQuery.of(context).padding;

    //Screen dimensions multiplier
    double safeScreenHeight= screenDimensions.height-padding.top-padding.bottom;
    double safeScreenWidth = screenDimensions.width-padding.left -padding.right;
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
        child: SafeArea(
          child: Container(
            width: safeScreenWidth,
            height: safeScreenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(//Top bar
                  color: kAppBarBackgroundColor,
                  width: safeScreenWidth*sdm,
                  height: kTopBarHeight*sdm,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text(
                        'Tibetan Handwritten Input Method',
                        style: TextStyle(
                          fontFamily:kMohave,
                          fontSize:26 * sdm,
                          color: kTWhite
                        ),
                      ),

                      SizedBox(width: 12*sdm), //Spacer

                      Container(
                        width: 25*sdm,
                        height: 25*sdm,
                        child: IconButton(
                          icon: Icon(
                            Icons.info_outline,
                            size: 24*sdm,
                            color: kTWhite
                          ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> InfoPage())
                            );
                          },
                          padding: EdgeInsets.zero
                        ),
                      ),
                    ]
                  ),
                ),
                MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create:(context) => AppBrain(
                        screenDims: screenDimensions,
                        safeScreenDims: Size(safeScreenWidth, safeScreenHeight),
                        safePadding: padding
                      )
                    ),
                  ],
                  child:MainBody()
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}