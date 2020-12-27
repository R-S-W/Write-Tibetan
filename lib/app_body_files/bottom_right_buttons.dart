
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styling_files/constants.dart';

import '../styling_files/custom_slider_thumb_rect.dart';
import '../styling_files/thumb_slider_delete_undo.dart';



class TsegShe extends StatefulWidget {
  TsegShe({Key key, 
    @required this.onPressed, 
    @required this.onSlid})
      :super(key: key);

  final VoidCallback onPressed;
  final VoidCallback onSlid;
  @override
  _TsegSheState createState() => _TsegSheState();
}

class _TsegSheState extends State<TsegShe> {
  double restValue = 1;
  ui.Image _image;
  @override
  void initState(){ /////////////idk?? lookat the warning when you hover over initstate
    super.initState();
    _loadImage();
  }
  _loadImage() async{
    ByteData bd = await rootBundle.load("assets/images/TsegShePic.png");
    final Uint8List bytes = Uint8List.view(bd.buffer);
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.Image image=(await codec.getNextFrame()).image;
    setState(()=> _image=image);
  }
  

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
          height: kTsegSheContainerDim.dx, //This is width, because widget is rotated.
          width: kTsegSheContainerDim.dy,//Similarly, this is height.
          // color: Color(0xaf000000),

          child: SliderTheme(
              data: SliderThemeData(
                  thumbShape: CustomSliderThumbRect(
                      min:0,
                      max:1,
                      thumbRadius: kRoundedButtonRadius,
                      thumbHeight: kTsegSheButtonDim.dy ,//*1.1,
                      thumbWidth:  kTsegSheButtonDim.dx,
                      image: _image,

                  ),
                thumbColor: kTsegSheButtonColor,
                // disabledThumbColor: Colors.blue,
                inactiveTrackColor: Color(0x00),
                activeTrackColor: Color(0x00),

              ),
              child: Slider(
                value: restValue,
                min: 0,
                max: 1,
                onChanged: (double value) {
                  setState(() {
                    restValue=value;
                  });
                },
                onChangeStart:(double startValue){
                  widget.onPressed();
                },
                onChangeEnd:(double endValue){
                  if (endValue == 0){// hopefully this doesnt need a tolerance
                    widget.onSlid();
                  }
                  setState((){
                    restValue=1;
                  });
                },
              )
          )
      ),
    );
  }
}


//DELETE UNDO BUTTON
class DeleteUndo extends StatelessWidget {

  final VoidCallback onPressed;
  final VoidCallback onLongPress;
  DeleteUndo({@required this.onPressed,@required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kDeleteUndoButtonDim.dx,
      height: kDeleteUndoButtonDim.dy,


      child: RaisedButton(
        onPressed: onPressed,
        onLongPress:onLongPress,
        child: Text(
          "\u21BA",
          style:TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: kDeleteUndoTextColor,
          )
        ),//Text("\u232B") ,
        color:kDeleteUndoButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRoundedButtonRadius)),
        ),




      ),
    );
  }
}


//
// class DeleteUndo extends StatefulWidget {
//
//   final VoidCallback onPressed;
//   final VoidCallback onSlid;
//   DeleteUndo({Key key,
//     @required this.onPressed,
//     @required this.onSlid})
//       :super(key: key);
//
//   @override
//   _DeleteUndoState createState() => _DeleteUndoState();
// }
//
// /// This is the private State class that goes with MyStatefulWidget.
// class _DeleteUndoState extends State<DeleteUndo> {
//   double restValue = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: <Widget>[
//         Container(),
//         Container(
//           color:Colors.black,
//           width: 70,
//           height: 90,
//           child: SliderTheme(
//             data: SliderThemeData(
//                 thumbShape: ThumbSliderDeleteUndo(
//                     min:0,
//                     max:1,
//                     thumbRadius: 15,
//                     thumbHeight: 70,
//                     text: "\u232B"
//                 )
//             ),
//             child: Slider(
//               value: restValue,
//               min: 0,
//               max: 1,
//               onChanged: (double value) {
//                 setState(() {
//                   restValue=value;
//                 });
//               },
//
//               onChangeStart:(double startValue){
//                 widget.onPressed();
//               },
//
//               onChangeEnd:(double endValue){
//                 if (endValue == 0){// hopefully this doesnt need a tolerance
//                   widget.onSlid();
//                 }
//                 setState((){
//                   restValue=1;
//                 });
//               },
//             ),
//           ),
//         ),
//
//
//
//
//
//       ],
//     );
//   }
// }








