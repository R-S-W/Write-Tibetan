import 'package:flutter/material.dart';



class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "InfoPage",
      home: WillPopScope(
        onWillPop: () => Future.value(false),

        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              }
            ),
            title: Center(
              child: Text("Information"),
            ),
          ),

        ),
      ),
    );
  }
}
