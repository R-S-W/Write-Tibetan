
import 'dart:ui';
import 'package:flutter/material.dart';
import 'bottom_right_buttons.dart';

import 'package:provider/provider.dart';
import '../letter_suggestion_files/my_change_notifier_classes.dart';
import '../styling_files/constants.dart';
import 'dart:math' as m;


class WritingStack extends StatefulWidget {
  WritingStack({@required this.strokeList, });
  final List<List<Offset>> strokeList;   //this is ok

  @override
  _WritingStackState createState() => _WritingStackState();
}
class _WritingStackState extends State<WritingStack>{


  List<Offset> points = List();
  /*isInBounds used to make sure a stroke that goes out of bounds has only the
  in-bounds position data saved. */
  bool isInBounds = false;

  @override

  Widget build(BuildContext context){
    return  Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(// redundant, the size of the pad
          width: kWritingStackDim.dx,
          height: kWritingStackDim.dy,
        ),

        GestureDetector(
          child:ClipRect(
            child: CustomPaint(
              foregroundPainter: WordPainter(
                strokeList: widget.strokeList,
              ),
                // size: Size(MediaQuery.of(context).size.width,280)
                child: Container(            //edit02, child container -> parent container
                  height: kWritingStackDim.dy,
                  width: kWritingStackDim.dx,
                  color: kWritingPadColor,
                )
            )
          ),

          onPanDown: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points =<Offset>[renderBox.globalToLocal(details.globalPosition)];
              //add first point,
              points.add(renderBox.globalToLocal(details.globalPosition));
              widget.strokeList.add(points);
              isInBounds = true;
            });
          },

          onPanUpdate: (details){
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              Offset tempPoint =renderBox.globalToLocal(details.globalPosition);
              //if not in bounds
              if (!(Offset.zero<=tempPoint && tempPoint<=kWritingStackDim)){
                isInBounds=  false;
              }
              if (isInBounds){
                points.add(tempPoint);
              }
            });
          },

          onPanEnd: (details){setState((){
            var appBrain = Provider.of<AppBrain>(context, listen:false);
            appBrain.suggestLetters();
          });}
        ),


        Container(//Rightmost Buttons
          padding: const EdgeInsets.only(right: kMargin, bottom: kMargin),
          alignment: Alignment.centerRight,
          width: kRightmostButtonsDim.dx,
          height: kWritingStackDim.dy,
          // height:kRightmostButtonsDim.dy ,

          child:  Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,

          children: <Widget>[
            // PunctuationButtons(),
            TsegShe(
              onPressed: (){
                var appBrain = Provider.of<AppBrain>(context, listen:false) ;
                //Display the tseg.
                if (appBrain.getSuggestionsLength()>0){
                  //if there's suggestions, add 1st suggested letter first.
                  appBrain.addWord(appBrain.getSuggestionAt(0));
                }
                appBrain.addWord('་');
                appBrain.clearAllStrokesAndSuggestions(); //Clear the strokes+suggestions
              },
              onSlid: (){
                //Display the tseg
                var appBrain =Provider.of<AppBrain>(context, listen:false);
                //onPressed always precedes onSlid.  Delete tseg, add she.
                appBrain.deleteWord();
                appBrain.addWord('།');
                //Clear the strokes+suggestions
                appBrain.clearAllStrokesAndSuggestions();
              }
            ),

            //enterButton()

            SizedBox(height: kMargin + 15.0 - m.max(0,80- kTsegSheButtonDim.dy)/2 ),

            DeleteUndo(
              onPressed: (){//Delete latest stroke
                var appBrain = Provider.of<AppBrain>(context, listen:false);
                appBrain.deleteStroke();
              },

              onLongPress: (){ //Delete all strokes
                var appBrain = Provider.of<AppBrain>(context, listen:false);
                appBrain.clearAllStrokesAndSuggestions();
                //Don't Delete this comment.  widget.StrokeList.clear();  Not needed because consumer handles this. Use if not using changenotifier.
              },
            ),

            SizedBox(height: kMargin),

            Container(//ENTER BUTTON
              width: kEnterButtonDim.dx,
              height:kEnterButtonDim.dy ,

              child: RaisedButton(
                child: Text(
                  "Enter",
                  style: TextStyle(
                    fontFamily: kShipporiAntiqueB1,
                    fontSize:22.0,
                    color: kButtonTextColor,
                    letterSpacing: -.5,
                  ),
                ),
                onPressed: () {
                  var appBrain =Provider.of<AppBrain>(context, listen:false) ;
                  appBrain.addWord('\n');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(kRoundedButtonRadius)),
                  side:BorderSide(
                    color: kBottomRightButtonsBorderColor,
                    width:kBottomRightButtonsBorderWidth
                  )

                ),
                color: kEnterButtonColor,

              ),
            ),


          ]
        ))],
    );
  }
}




class WordPainter extends CustomPainter{
  WordPainter({this.strokeList});
  List<List<Offset>> strokeList ;
  List<Offset> offsetPoints= List();
  @override
  void paint(Canvas canvas, Size size){
    final paintSettings = Paint()
      ..color= Colors.black
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    for (int i=0; i< strokeList.length; i++){
      // canvas.drawPoints(PointMode.points, strokeList[i], paintSettings );//
      for (int j=0; j< strokeList[i].length-1; j++){
        //draw endpoints
        canvas.drawPoints(
            PointMode.points,
            [strokeList[i].first, strokeList[i].last],
            paintSettings );
        //draw rest of stroke
        canvas.drawLine(strokeList[i][j], strokeList[i][j+1],paintSettings);
      }
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}



