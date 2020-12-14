
import 'dart:ui';
import 'package:flutter/material.dart';
import 'bottom_right_buttons.dart';

import 'package:provider/provider.dart';
import '../letter_suggestion_files/my_change_notifier_classes.dart';
import '../styling_files/constants.dart';


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
          // color: kWritingPadColor,
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
            var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
            stroke2Sug.suggestLetters();
          });}
        ),


        Container(//Rightmost Buttons
          alignment: Alignment.centerRight,
          width: kRightmostButtonDim.dx,
          height:kRightmostButtonDim.dy ,

          child:  Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            // PunctuationButtons(),
            TsegShe(
              onPressed: (){
                var sug2Disp = Provider.of<SuggestionToDisplay>(context) ;
                var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
                //Display the tseg.
                if (stroke2Sug.getSuggestionsLength()>0){
                  //if there's suggestions, add 1st suggested letter first.
                  sug2Disp.addWord(stroke2Sug.getSuggestionAt(0));
                }
                sug2Disp.addWord('་');
                stroke2Sug.clearAll(); //Clear the strokes+suggestions
              },
              onSlid: (){
                //Display the tseg
                var sug2Disp =Provider.of<SuggestionToDisplay>(context);
                //onPressed always precedes onSlid.  Delete tseg, add she.
                sug2Disp.deleteWord();
                sug2Disp.addWord('།');
                //Clear the strokes+suggestions
                var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
                stroke2Sug.clearAll();
              }
            ),

            //enterButton()

            Expanded(
              child: Container(
                // width: kRightmostButtonDim.dx,
                // height:kRightmostButtonDim.dy/2- 20 ,
                color:Colors.red
              ),
            ),
            DeleteUndo(
              onPressed: (){//Delete latest stroke
                var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
                stroke2Sug.suggestLetters();
                if (widget.strokeList.length > 0 ) {
                  widget.strokeList.removeLast();
                }
              },

              onSlid: (){ //Delete all strokes
                var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
                stroke2Sug.clearAll();
                //Don't Delete this comment.  widget.StrokeList.clear();  Not needed because consumer handles this. Use if not using changenotifier.
              },
            ),


            Container(
              width: kRightmostButtonDim.dx,
              height:kRightmostButtonDim.dy/6 ,
              child: RaisedButton(
                child: Text(
                  "Enter",
                  style: TextStyle(
                    fontSize:20.0,
                  ),
                ),
                onPressed: () {
                  var sug2Disp =Provider.of<SuggestionToDisplay>(context) ;
                  sug2Disp.addWord('\n');
                },

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



