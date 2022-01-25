
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../letter_suggestion_files/my_change_notifier_classes.dart';
import '../styling_files/constants.dart';


class TextDisplay extends StatefulWidget {
  TextDisplay({Key key, @required this.deleteWordCallback,
    @required this.clearSentenceCallback,
    @required this.copyTextCallback}):super(key: key);

  final VoidCallback deleteWordCallback;
  final VoidCallback clearSentenceCallback;
  final VoidCallback copyTextCallback;
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
            Positioned(//Display
              top:0,
              left:0,
              width:kScreenDim.dx,
              height:290,
              child: Container(//Background Container
                color: kAppBarBackgroundColor,
                child: Container(
                  padding: EdgeInsets.only(left: kTextMargin),
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
                      readOnly: true,
                      showCursor: true,
                      maxLines: null,
                      decoration: null, //InputDecoration(),
                      cursorColor: Colors.red,
                      style: TextStyle(
                        fontSize: kTextFontSize,
                      )
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Row(//Copy, Delete Buttons
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 60,
                    child: RaisedButton(
                      color: kDeleteButtonColor,
                      child:Text(
                        "Copy\nAll",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: kShipporiAntiqueB1,
                          fontSize: 18,
                          color: kButtonTextColor,
                          letterSpacing: -.5,
                        )
                      ),
                      onPressed: widget.copyTextCallback,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular( 1.5*kRoundedButtonRadius)),
                      ),
                    )
                  ),

                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color:kTRed,
                          height:60
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft:Radius.elliptical(15,20),
                              bottomRight: Radius.elliptical(15,20)
                            ),
                            color:kTWhite,
                          ),
                          height:60

                        )
                      ]
                    )

                  ),
                  Container( //DeleteButton
                    width: 80,
                    height: 60,
                    child: RaisedButton(
                      color: kCopyButtonColor,
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontFamily: kShipporiAntiqueB1,
                          fontSize: 19,
                          color: kButtonTextColor,
                          letterSpacing: -.5,
                        ),
                        softWrap: false,
                        overflow:TextOverflow.visible,
                      ),
                      onPressed: widget.deleteWordCallback,
                      onLongPress: widget.deleteWordCallback,//widget.clearSentenceCallback,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular( 1.5*kRoundedButtonRadius)),
                      ),
                    ),
                  ),

                ]
              ),
            ),

          ]
      ),
    );
  }
}
