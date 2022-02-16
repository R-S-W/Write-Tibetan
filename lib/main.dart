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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kAppBarBackgroundColor,
        title: Center(
            child: const Text(
              'Tibetan Handwritten Input Method',
              style: TextStyle(
                fontFamily:kMohave,
                fontSize:26,
              ),
            ),
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
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
      body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create:(context) => AppBrain(screenDims: screenDimensions)
            ),
          ],
          child:MainBody()
      )
    );
  }
}