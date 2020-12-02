import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'MyChangeNotifierClasses.dart';
import 'MainBody.dart';




void main() {
  runApp(
     MyApp()
  );
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Offset ScreenDim = Offset(414.0,896.0);



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(//Set to portrait orientation
        [DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
              title: Center(
                  child: const Text('Tibetan Handwritten Input Method')
              ),
              actions: <Widget>[
                Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                Icon(
                  Icons.auto_awesome,
                  color: Colors.red,
                ),
              ]
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => SuggestionToDisplay()),
              ChangeNotifierProvider(create: (context) => StrokesToSuggestion())
            ],
            child:MainBody()
          )
      ),
    );
  }
}




//______________________________________________________________________

