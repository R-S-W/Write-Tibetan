
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:tibetan_handwriting_app_0_1/app_body_files/text_display_button.dart';
import '../app_logic/app_brain.dart';
import '../styling_files/constants.dart';
import '../styling_files/custom_painters.dart';


class TextDisplay extends StatefulWidget {
  TextDisplay({Key key}):super(key: key);

  @override
  _TextDisplayState createState() => _TextDisplayState();
}

class _TextDisplayState extends State<TextDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kScreenDim.dx,
      height: kTextDisplayHeight,
      color: kTextDisplayColor,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(//Text Display
            top:0,
            left:0,
            width:kScreenDim.dx,
            height:290,
            child: Container(//Background Container
              color: kAppBarBackgroundColor,
              child: Container(
                padding: EdgeInsets.only(left: kTextMargin, top: kTextMargin),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.elliptical(17,20),
                    topRight: Radius.elliptical(17,20)
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
                    decoration: null, //InputDecoration(),
                    cursorColor: Colors.red,
                    cursorHeight: .9*cLineHeight,
                    style: TextStyle(
                      fontSize: kTextFontSize,
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
                    ),


                    TextDisplayButton(//PASTE BUTTON
                        label: 'Paste',
                        onPressed: (){
                          AppBrain appBrain = Provider.of<AppBrain>(context, listen: false);
                          FlutterClipboard.paste().then(
                            (pasteText) => appBrain.addWord(pasteText)
                          );
                        }
                    ),


                    TextDisplayButton(//UNDO BUTTON
                      label: 'Undo',
                      onPressed: (){
                        AppBrain appBrain = Provider.of<AppBrain>(context, listen: false);
                        appBrain.undo();
                      }
                    ),

                    TextDisplayButton(//REDO BUTTON
                        label: 'Redo',
                        onPressed: (){
                          AppBrain appBrain = Provider.of<AppBrain>(context, listen: false);
                          appBrain.redo();
                        }
                    ),


                    Container( //DELETE BUTTON
                      width: 80,
                      height: 60,
                      child: ElevatedButton(
                        child: Text(
                          "Delete",
                          style: kTextDisplayButtonTextStyle,
                          softWrap: false,
                          overflow:TextOverflow.visible,
                        ),
                        onPressed: (){
                          AppBrain appBrain = Provider.of<AppBrain>(context, listen:false);
                          appBrain.deleteWord();
                        },
                        style:  ElevatedButton.styleFrom(
                          primary: kCopyButtonColor,
                          shape:RoundedRectangleBorder(
                            borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(1.5 * kRoundedButtonRadius)
                            ),
                          )
                        )
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}