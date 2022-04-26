import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'text_display_button.dart';
import '../../../../app_logic/app_brain.dart';
import '../../../../styling_files/constants.dart';
import '../../../../styling_files/custom_painters.dart';
import 'delete_letter_button.dart';


class TextDisplay extends StatefulWidget {
  TextDisplay({Key key}):super(key: key);

  @override
  _TextDisplayState createState() => _TextDisplayState();
}

class _TextDisplayState extends State<TextDisplay> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sdm = screenWidth/kDevScreenWidth;



    return Expanded(
      // flex: 100,
      child: Container(
        width: screenWidth,
        color: kTextDisplayColor,
        child: Column(
          // alignment: Alignment.bottomCenter,
          children: <Widget>[
            Expanded(//Text Display
              child: Container(//Background Container
                color: kAppBarBackgroundColor,
                child: Container(
                  padding: EdgeInsets.only(left: kTextMargin, top: kTextMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.elliptical(17*sdm,20*sdm),
                      topRight: Radius.elliptical(17*sdm,20*sdm)
                    ),
                    color:kTextDisplayColor
                  ),

                  child: Consumer<AppBrain>(
                    builder: (context,appBrain, child)=> TextField(
                      controller: appBrain.textDisplayController,
                      scrollController: appBrain.textDisplayScrollController,
                      readOnly: true,
                      autofocus: true,
                      showCursor: true,
                      maxLines: null,
                      decoration: null,
                      cursorColor: Colors.red,
                      cursorHeight: kEstLineHeight*sdm,
                      style: TextStyle(
                        fontSize: kTextFontSize*sdm,
                      )
                    ),
                  ),
                ),
              ),
            ),
            ClipRect(//BUTTON ROW
              child: CustomPaint(
                painter: ButtonRowBackgroundPainter(),
                child: Container(
                  child: Row(//Copy, Delete Buttons
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextDisplayButton.left(//COPY BUTTON
                        label: 'Copy\nAll',
                        onPressed: (){
                          AppBrain appBrain = Provider.of<AppBrain>(context, listen:false);
                          FlutterClipboard.copy(appBrain.getTextDisplaySentence());
                        },
                        scaleFactor: sdm
                      ),


                      TextDisplayButton(//PASTE BUTTON
                        label: 'Paste',
                        onPressed: (){
                          AppBrain appBrain = Provider.of<AppBrain>(context, listen: false);
                          FlutterClipboard.paste().then(
                            (pasteText) => appBrain.paste(pasteText)
                          );
                        },
                        scaleFactor: sdm
                      ),


                      TextDisplayButton(//UNDO BUTTON
                        label: 'Undo',
                        onPressed: (){
                          AppBrain appBrain = Provider.of<AppBrain>(context, listen: false);
                          appBrain.undo();
                        },
                        scaleFactor: sdm
                      ),

                      TextDisplayButton(//REDO BUTTON
                        label: 'Redo',
                        onPressed: (){
                          AppBrain appBrain = Provider.of<AppBrain>(context, listen: false);
                          appBrain.redo();
                        },
                        scaleFactor: sdm
                      ),


                      DeleteLetterButton(
                        onPressed: (){
                            AppBrain appBrain = Provider.of<AppBrain>(context, listen:false);
                            appBrain.deleteWord();
                          },
                        onLongPress:(){
                            AppBrain appBrain = Provider.of<AppBrain>(context, listen:false);
                            appBrain.clearSentence();
                          },
                        scaleFactor: sdm
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}