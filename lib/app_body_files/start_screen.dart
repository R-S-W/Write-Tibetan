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
      // color: kTGreen,
      decoration:BoxDecoration(
        gradient:LinearGradient(
          begin:Alignment.topCenter,
          end:Alignment.bottomCenter,
          colors: [Color(0xFF005C9F),Color(0xFF318A90)],
          //colors: [Color(0xFF004C84),Color(0xFF318A90)],
          stops: [.2,.8]
        )
      ),
      child: SafeArea(
          child: Container(
            width: safeScreenWidth,
            height: safeScreenHeight,
            // color: Color(0x9e705010),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 0,(35+25).toDouble()),
                  child: Text('Write\nTibetan',
                    style:TextStyle(
                      color: kTWhite,
                      fontSize:110,
                      height: 1.1,
                      // fontFamily: kBigShouldersInlineText,
                      // fontWeight: FontWeight.w600,
                      fontFamily: kSairaCondensed,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextButton(
                  child: Text("Write",
                    style: kModeButtonTextStyle
                  ),
                  onPressed: ()=>Navigator.pushNamed(context, '/writing')
                ),
                SizedBox(height: 10),
                TextButton(
                  child: Text("Study",
                    style: kModeButtonTextStyle
                  ),
                  onPressed: ()=>Navigator.pushNamed(context,'/practice')
                ),



                // Padding(
                //   child: Text('བྲིས་བོད་ཡིག',
                //     style: TextStyle(
                //       fontSize: 100,
                //       color: kTWhite
                //       //Color(0x99ffffff)
                //     )
                //   ),
                //   padding: EdgeInsets.fromLTRB(0,60,0,0),
                // ),
                Expanded(child: Container()),
                Padding(
                  child: Text("Created by Raymond Wu",
                    style:TextStyle(
                      color: kTWhite
                    )
                  ),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                )
              ]
            )

          )
      ),
    );
  }
}
