
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
// import 'WritingPad.dart';
import 'BottomRightButtons.dart';
import 'dart:convert';
import 'package:utf/utf.dart';


import 'package:provider/provider.dart';
import 'MyChangeNotifierClasses.dart';


class WritingStack extends StatefulWidget {


  List<List<Offset>> StrokeList;
  // void Function(List<Offset> aStroke ) strokeDetectCallback;
  // final VoidCallback DeleteUndoDeleteStrokeCallback;
  // final VoidCallback DeleteUndoClearAllCallback;

  WritingStack({@required this.StrokeList, });    //@required this.strokeDetectCallback
   // @required this.DeleteUndoDeleteStrokeCallback,
   //  @required this.DeleteUndoClearAllCallback,});


  @override
  _WritingStackState createState() => _WritingStackState();
}
  class _WritingStackState extends State<WritingStack>{
    Offset WritingStackDim = Offset(414.0, 280.0);
    Offset RightmostButtonDim = Offset(100.0, 280.0);



    final Offset WritingPadDim = Offset(414.0,280.0); //MediaQuery.of(context).size.width);
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
            width:WritingStackDim.dx,
            height: WritingStackDim.dy,
          ),


          GestureDetector(
            child:ClipRect(
              child: CustomPaint(
                foregroundPainter: WordPainter(
                  strokeList: widget.StrokeList,
                ),
                  // size: Size(MediaQuery.of(context).size.width,280)
                  child: Container(                //edit02, child container -> parent container
                    height: WritingPadDim.dy,
                    width: WritingPadDim.dx,
                    color: Colors.blue[200],
                  )
              )
            ),



            onPanDown: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                points = <Offset>[renderBox.globalToLocal(details.globalPosition)];
                points.add(renderBox.globalToLocal(details.globalPosition));//add first point,
                widget.StrokeList.add(points);
                isInBounds = true;
                // widget.strokeDetectCallback(points);



              });

              // print("Length: ${widget.StrokeList.length}");
            },


            onPanUpdate: (details){
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                Offset TempPoint = renderBox.globalToLocal(details.globalPosition);

                if (!(Offset.zero<=TempPoint && TempPoint<=WritingPadDim)){//not in bounds
                  isInBounds=  false;
                }
                if (isInBounds){
                  points.add(TempPoint);
                }
              });
            },


            onPanEnd: (details){setState((){
              var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
              stroke2Sug.suggestLetters();

              // List a= <int>[];
              // for (int i=0; i< widget.StrokeList.length; i++){
              //   a.add(widget.StrokeList[i].length);
              // }
              // print(a);
              //// convert from points+time to pathnumber
            });}
          ),



          Container(//Rightmost Buttons
            alignment: Alignment.centerRight,
            width: RightmostButtonDim.dx,
            height:RightmostButtonDim.dy ,

            child:  Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,

            children: <Widget>[
              // PunctuationButtons(),
              TsegShe(
                onPressed: (){
                  var sug2Disp =Provider.of<SuggestionToDisplay>(context) ;//Display the tseg
                  sug2Disp.addWord('་');
                  var stroke2Sug = Provider.of<StrokesToSuggestion>(context);//Clear the strokes+suggestions
                  stroke2Sug.clearAll();
                },
                onSlid: (){
                  var sug2Disp =Provider.of<SuggestionToDisplay>(context) ;//Display the tseg
                  sug2Disp.deleteWord(); //This is done because onPressed always precedes onSlid.
                  sug2Disp.addWord('།');
                  var stroke2Sug = Provider.of<StrokesToSuggestion>(context);//Clear the strokes+suggestions
                  stroke2Sug.clearAll();
                }
              ),

              //enterButton()

              Container(
                width: RightmostButtonDim.dx,
                height:RightmostButtonDim.dy/2- 20 ,
                color:Colors.red
              ),
              DeleteUndo(
                onPressed: (){//Delete latest stroke
                  // widget.DeleteUndoDeleteStrokeCallback;
                  var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
                  stroke2Sug.suggestLetters();

                  // print(" \u0f42\u0f7c  ");    //གོ  is \u0f42\u0f7c      ska is \u0f66\u0F90 ... i think
                  // var thenumber = encodeUtf16be("གོ");
                  // print(thenumber);
                  // var theothernum = [15,102,  15, 124];// we will use སོ, \u0f66\u0f7c
                  // print( decodeUtf16( theothernum ) );////
                  //
                  // print("thenumber encoded: $thenumber");

                  // ithink this doesnt work  print (decodeUtf16be(Base64Decoder().convert('ཀོ')) );
                  if (widget.StrokeList.length > 0 ) {
                    widget.StrokeList.removeLast();
                  }
                },

                onSlid: (){ //Delete all strokes
                  // widget.DeleteUndoClearAllCallback;
                  var stroke2Sug = Provider.of<StrokesToSuggestion>(context);
                  stroke2Sug.clearAll();
                  //Don't Delete this comment.  widget.StrokeList.clear();  Not needed because consumer handles this. Use if not using changenotifier.

                },
              ),
              ]
          )

          )],
    );

  }
}




class WordPainter extends CustomPainter{
  List<List<Offset>> strokeList ;

  WordPainter({this.strokeList});

  List<Offset> offsetPoints= List();
  @override
  void paint(Canvas canvas, Size size){

    final paintSettings = Paint()
      ..color= Colors.black
      ..isAntiAlias = true
      ..strokeWidth = 3.0;


    for (int i=0; i< strokeList.length; i++){
      // canvas.drawPoints(PointMode.points, strokeList[i], paintSettings );//
      for (int j=0; j< strokeList[i].length-1; j++){
        //draw endpoints
        canvas.drawPoints(PointMode.points, [strokeList[i].first, strokeList[i].last], paintSettings );
        //draw rest of stroke
        canvas.drawLine(strokeList[i][j], strokeList[i][j+1],paintSettings);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}



