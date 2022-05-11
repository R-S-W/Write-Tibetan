import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'practice_character_button.dart';
import '../../styling_files/constants.dart';

import '../../app_logic/practice_mode_brain.dart';

const double kGridSpacing = 20;

class PracticeMode extends StatelessWidget {
  const PracticeMode({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenDims = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    double sdm = screenDims.width / kDevScreenWidth;
    double safeScreenHeight= screenDims.height-padding.top-padding.bottom;
    double safeScreenWidth = screenDims.width-padding.left -padding.right;

    List<Widget> alphabetList = <Widget>[];
    List<Widget> vowelList = <Widget>[];
    for (int i =0; i<30; i++){
      alphabetList.add(PracticeCharacterButton(kAlphabet[i]));
    }
    for (int i=30; i<kAlphabet.length; i++){
      vowelList.add(PracticeCharacterButton(kAlphabet[i]));
    }




    return SafeArea(
      child: Container(
        height: safeScreenHeight,
        width: safeScreenWidth,
        decoration:BoxDecoration(
          gradient: LinearGradient(
            colors:[Color(0xFF538F73),Color(0xff336270)],
            //0xFF568463
            //#B91C00
              //0xff15333C
                //0xff20454e
            begin:Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops:[0,.85]
          )
        ),
        child: ChangeNotifierProvider(
          create:(context) => PracticeModeBrain(),
          child: Container(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(//Top bar
                    color: kAppBarBackgroundColor,
                    width: safeScreenWidth,
                    height: 50*sdm,
                    padding: EdgeInsets.symmetric(horizontal: 20*sdm),
                    child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Align(
                            alignment: Alignment(-1.0,-.2),
                            child: Container(//Back to StartScreen
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
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'The Tibetan Alphabet',
                              style: TextStyle(
                                  fontFamily:kMohave,
                                  fontSize:35 * sdm,
                                  color: kTWhite
                              ),
                            ),
                          ),

                          // SizedBox(width: 12*sdm), //Spacer

                        ]
                    ),
                  ),
                ),
                // Text('The Tibetan Alphabet'),
                Expanded(
                  child: Align(
                    alignment:Alignment.center,
                    child: SizedBox(
                      width: 270,
                      height: 682,


                      child: Container(
                        // color: Color(0xff6ca792),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Wrap(
                              spacing: kGridSpacing,
                              runSpacing: kGridSpacing,
                              alignment: WrapAlignment.center,
                              children: alphabetList
                            ),
                            SizedBox(height: kGridSpacing),
                            Wrap(
                              spacing:kGridSpacing,
                              runSpacing: kGridSpacing,
                              children: vowelList
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
            )
          )
          // Container(width: 100, height: 100, color: Colors.red)

        ),
      ),
    );
  }
}