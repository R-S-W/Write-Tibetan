import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_logic/app_brain.dart';
import '../../styling_files/constants.dart';
import 'main_body/info_screen.dart';
import 'main_body/suggestion_bar.dart';
import 'main_body/text_display/text_display.dart';
import 'main_body/writing_stack/writing_stack.dart';



class WritingMode extends StatefulWidget {
  @override
  _WritingModeState createState() => _WritingModeState();
}

class _WritingModeState extends State<WritingMode> {
  @override
  Widget build(BuildContext context) {
    Size screenDims = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    double sdm = screenDims.width / kDevScreenWidth;
    var appBar = Provider.of<AppBrain>(context, listen:false);
    Size safeScreenDims = appBar.safeScreenDims;
    double safeScreenHeight= screenDims.height-padding.top-padding.bottom;
    double safeScreenWidth = screenDims.width-padding.left -padding.right;


    return Stack(
      children: <Widget>[
        SafeArea(
          child: Container(
            width: safeScreenWidth,
            height: safeScreenHeight,
            child: Column(//Main App
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(//Top bar
                  color: kAppBarBackgroundColor,
                  width: safeScreenWidth,
                  height: kTopBarHeight*sdm,
                  padding: EdgeInsets.symmetric(horizontal: 30*sdm),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children:[

                        Container(//Back to StartScreen
                          width: 25*sdm,
                          height: 25*sdm,
                          child: IconButton(
                              icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 24*sdm,
                                  color: kTWhite
                              ),
                              onPressed: ()=>Navigator.pop(context),
                              padding: EdgeInsets.zero
                          ),
                        ),

                        Text(
                          'Write Tibetan',
                          style: TextStyle(
                              fontFamily:kMohave,
                              fontSize:26 * sdm,
                              color: kTWhite
                          ),
                        ),

                        // SizedBox(width: 12*sdm), //Spacer

                        Container(
                          width: 25*sdm,
                          height: 25*sdm,
                          child: IconButton(
                              icon: Icon(
                                  Icons.question_mark_outlined,
                                  size: 24*sdm,
                                  color: kTWhite
                              ),
                              onPressed: (){
                                AppBrain appBrain =
                                Provider.of<AppBrain>(context,listen:false);
                                appBrain.turnInfoScreenPage();
                              },
                              padding: EdgeInsets.zero
                          ),
                        ),
                      ]
                  ),
                ),
                //   Main App
                Container(
                  width: safeScreenDims.width,
                  height: safeScreenDims.height - kTopBarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children : <Widget>[
                      TextDisplay(),


                      SizedBox(
                          height: kTrimHeight*sdm,
                          width: screenDims.width,
                          child: Container(
                            color: kSuggestionBarBorderlineColor1,
                          )
                      ),


                      SuggestionBar(),


                      SizedBox(
                          height: kTrimHeight*sdm,
                          width: screenDims.width,
                          child: Container(
                            color: kSuggestionBarBorderlineColor2,
                          )
                      ),


                      WritingStack(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        Container(
          width:screenDims.width,
          height: screenDims.height,
          child: Consumer<AppBrain>(
              builder: (context,appBrain,child) =>
                  InfoScreen(
                      pageContents: appBrain.currentInfoScreenPage,
                      onPressed: appBrain.turnInfoScreenPage,
                      screenDims: appBrain.screenDims,
                      safeScreenDims: appBrain.safeScreenDims,
                      scaleFactor: sdm
                  )
          ),
        )
      ],
    );
  }
}