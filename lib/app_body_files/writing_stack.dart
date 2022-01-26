
import 'dart:ui';
import 'package:flutter/material.dart';
import 'bottom_right_buttons.dart';
import 'bottom_button.dart';

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


  List<Offset> points = [];
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
                strokeList: widget.strokeList
              ),
                child: Container(
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
          child:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TsegShe(
              onPressed: (){
                var appBrain = Provider.of<AppBrain>(context, listen:false) ;
                //Display the tseg.
                if (appBrain.getSuggestionsLength()>0){
                  //if there's suggestions, add 1st suggested letter first.
                  appBrain.addWord(appBrain.getSuggestionAt(0));
                }
                appBrain.addWord('་');
                //Clear the strokes+suggestions
                appBrain.clearAllStrokesAndSuggestions();
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

            SizedBox(height: kMargin + 15.0 - m.max(0,80- kTsegSheButtonDim.dy)/2 ),

            DeleteUndo(
              onPressed: (){//Delete latest stroke
                var appBrain = Provider.of<AppBrain>(context, listen:false);
                appBrain.deleteStroke();
              },
              onLongPress: (){ //Delete all strokes
                var appBrain = Provider.of<AppBrain>(context, listen:false);
                appBrain.clearAllStrokesAndSuggestions();
                /* Remember: widget.StrokeList.clear();  Not needed because
                  consumer handles this. Use if not using changenotifier.  */
              },
            ),

            SizedBox(height: kMargin),

            BottomButton(//ENTER BUTTON
              label: 'Enter',
              color: kEnterButtonColor,
              onPressed: () {
                var appBrain = Provider.of<AppBrain>(context, listen:false);
                appBrain.addWord('\n');
              },
            )

          ]
        )),


        Positioned(//SPACEBAR
          left: kMargin,
          bottom: kMargin,
          child: BottomButton(
            label: 'Space',
            color: kSpacebarColor,
            onPressed: (){
              var appBrain = Provider.of<AppBrain>(context, listen: false);
              appBrain.addWord(' ');
            },
          )
        )
      ],
    );
  }
}




class WordPainter extends CustomPainter{
  WordPainter({this.strokeList});
  List<List<Offset>> strokeList;
  List<Offset> offsetPoints= [];
  @override
  void paint(Canvas canvas, Size size){
    final paintSettings = Paint()
      ..color= Colors.black
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    for (int i=0; i< strokeList.length; i++){
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



