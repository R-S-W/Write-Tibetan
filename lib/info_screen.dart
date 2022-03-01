import 'package:flutter/material.dart';
import './styling_files/constants.dart';



class InfoScreen extends StatelessWidget {
  final bool isVisible;

  InfoScreen({@required this.isVisible});

  @override
  Widget build(BuildContext context) {
    if (isVisible) {
      return MaterialApp(
        color: Colors.transparent,
        title: "Information",
        home: WillPopScope(
          onWillPop: () => Future.value(false),

          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(

                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                ),
                title: Center(
                  child: Text("Information"),
                ),
                backgroundColor: kAppBarBackgroundColor
            ),

          ),
        ),
      );
    }else{
      return Container();
    }
  }
}
