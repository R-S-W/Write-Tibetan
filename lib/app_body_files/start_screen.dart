import 'package:flutter/material.dart';
import '../styling_files/constants.dart';



class StartScreen extends StatelessWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size screenDims = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    double sdm = screenDims.width / kDevScreenWidth;
    double safeScreenHeight= screenDims.height-padding.top-padding.bottom;
    double safeScreenWidth = screenDims.width-padding.left -padding.right;

    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Container(
            width: safeScreenWidth,
            height: safeScreenHeight,
            color:Colors.green,
            child: Column(
              children: <Widget>[
                Text('Write Tibetan'),
                TextButton(
                  child: Text("Writing Mode"),
                  onPressed: ()=>Navigator.pushNamed(context, '/writing')
                ),
                TextButton(
                  child: Text("Practice Mode"),
                  onPressed: ()=>Navigator.pushNamed(context,'/practice')
                )
              ]
            )

          )
      ),
    );
  }
}
