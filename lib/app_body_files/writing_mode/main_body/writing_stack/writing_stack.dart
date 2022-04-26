import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_logic/app_brain.dart';
import 'bottom_right_buttons.dart';
import 'bottom_button.dart';
import '../../../styling_files/constants.dart';
import '../../../styling_files/custom_painters.dart';


class WritingStack extends StatefulWidget {

  @override
  _WritingStackState createState() => _WritingStackState();
}
class _WritingStackState extends State<WritingStack>{


  List<Offset> newStroke = [];
  /*isInBounds used to make sure a stroke that goes out of bounds has only the
  in-bounds position data saved. */
  bool isInBounds = false;

  @override
  Widget build(BuildContext context){
    double sdm = MediaQuery.of(context).size.width/kDevScreenWidth;

    return  Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Container(// redundant, the size of the pad
          width: kWritingStackDim.dx*sdm,
          height: kWritingStackDim.dy*sdm,
        ),


        Consumer<AppBrain>(
          builder: (context, appBrain,child)=>
            GestureDetector(
              child:ClipRect(
                child: CustomPaint(
                  foregroundPainter: StrokePainter(
                    strokeList: appBrain.strokeList
                  ),
                    child: Container(
                      height: kWritingStackDim.dy*sdm,
                      width: kWritingStackDim.dx*sdm,
                      color: kWritingPadColor,
                    )
                )
            ),

            onPanDown: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                newStroke =<Offset>[];
                //add first point,
                newStroke.add(renderBox.globalToLocal(details.globalPosition));

                appBrain.strokeList.add(newStroke);
                isInBounds = true;
              });
            },

            onPanUpdate: (details){
              setState(() {
                RenderBox renderBox = context.findRenderObject();
                Offset tempPoint =renderBox.globalToLocal(details.globalPosition);
                //if not in bounds
                if (!(Offset.zero<=tempPoint && tempPoint<=kWritingStackDim)){
                  //isInBounds is False, and any subsequent points of onPanUpdates
                  //will not be added.  This prevents re-entrant, disconnected
                  // strokes (where you draw out of the canvas and then come
                  // back in)
                  isInBounds=  false;
                }
                if (isInBounds){
                  newStroke.add(tempPoint);
                }
              });
            },

            onPanEnd: (details){
              setState( appBrain.suggestLetters );
            }
          ),
        ),


        Container(//Rightmost Buttons
          padding: const EdgeInsets.only(right: kMargin, bottom: kMargin),
          alignment: Alignment.centerRight,
          width: kRightmostButtonsDim.dx*sdm,
          height: kWritingStackDim.dy*sdm,
          child:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TsegShe(
              onPressed: (){
                var appBrain = Provider.of<AppBrain>(context, listen:false) ;

                //Display the tseg.
                if (appBrain.suggestions.length>0){
                  //if there's suggestions, add 1st suggested letter first.
                  appBrain.addWord(appBrain.suggestions[0]);
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
              },
              scaleFactor: sdm
            ),

            SizedBox(height: 4*sdm),

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
              scaleFactor: sdm
            ),

            SizedBox(height: kMargin*sdm),

            BottomButton(//ENTER BUTTON
              label: 'Enter',
              color: kEnterButtonColor,
              onPressed: () {
                var appBrain = Provider.of<AppBrain>(context, listen:false);
                appBrain.addWord('\n');
              },
              scaleFactor: sdm
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
            scaleFactor: sdm
          )
        )
      ],
    );
  }
}


