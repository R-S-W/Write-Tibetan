import 'package:flutter/material.dart';


class WritingPad extends StatefulWidget {
  List<List<Offset>>  strokeList;

  WritingPad({Key key,this.strokeList}): super(key:key);

  @override
  _WritingPadState createState()=> _WritingPadState();
}

class _WritingPadState extends State<WritingPad> {
  List<Offset> points = [];
  ///
  /*isInBounds used to make sure a stroke that goes out of bounds has only the
  in-bounds position data saved. */
  bool isInBounds = false;

  final Offset writingPadDim = Offset(414.0,280.0);     //MediaQuery.of(context).size.width);



  @override
  Widget build(BuildContext context){

    return
    GestureDetector(
      child:ClipRect(
        child: CustomPaint(
          foregroundPainter: WordPainter(
            strokeList: widget.strokeList,
          ),

          // size: Size(MediaQuery.of(context).size.width,280)



            child: Container(                //edit02, child container -> parent container
              height: writingPadDim.dy,
              width: writingPadDim.dx,
              color: Colors.blue[200],
            )
        )
      ),



      onPanDown: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          points = <Offset>[renderBox.globalToLocal(details.globalPosition)];
          widget.strokeList.add(points);

          isInBounds = true;
        });
      },



      onPanUpdate: (details){
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          Offset tempPoint = renderBox.globalToLocal(details.globalPosition);

          if (!(Offset.zero<=tempPoint && tempPoint<=writingPadDim)){//not in bounds
            isInBounds=  false;
          }
          if (isInBounds){
            points.add(tempPoint);
          }
        });
      },


      onPanEnd: (details){
        setState((){
          List a= <int>[];
          for (int i=0; i< widget.strokeList.length; i++){
            a.add(widget.strokeList[i].length);
          }
          print(a);
          //// convert from points+time to pathnumber
        });
      }
    );
  }
}


class WordPainter extends CustomPainter{
  WordPainter({this.strokeList});
  List<List<Offset>> strokeList ;

  List<Offset> offsetPoints= <Offset>[];
  @override
  void paint(Canvas canvas, Size size){

    final paintSettings = Paint()
      ..color= Colors.black
      ..isAntiAlias = true
      ..strokeWidth = 3.0;


    for (int i=0; i< strokeList.length; i++){
      for (int j=0; j< strokeList[i].length-1; j++){
        canvas.drawLine(strokeList[i][j], strokeList[i][j+1],paintSettings);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}