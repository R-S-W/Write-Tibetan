import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tibetan_handwriting_app_0_1/practice_letter_button.dart';
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';

import 'app_logic/practice_mode_brain.dart';

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

    String alphabet= "ཀཁགངཅཆཇཉཏཐདནཔཕབམཙཚཛཝཞཟཡའརལཤསཧཨ";
    List<Widget> alphabetList = <Widget>[];
    for (int i =0; i<alphabet.length; i++){
      alphabetList.add(PracticeLetterButton(alphabet[i]));
    }



    return SafeArea(
      child: Container(
        height: safeScreenHeight,
        width: safeScreenWidth,
        child: ChangeNotifierProvider(
          create:(context) => PracticeModeBrain(),
          child: Container(
            child: Column(
              children: <Widget>[
                Text('Basic Alphabet'),
                SizedBox(
                  width: 300,
                  height: 400,

                  child: Container(
                    color: Color(0xff6ca792),
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: alphabetList
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