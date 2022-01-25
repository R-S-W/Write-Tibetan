
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styling_files/constants.dart';
import '../styling_files/custom_slider_thumb_rect.dart';



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
  void initState(){
    super.initState();
    _loadImage();
  }
  _loadImage() async{
    ByteData bd = await rootBundle.load("assets/images/TsegSheWhitePic.png");
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
        //Width and height are switched because the widget is rotated.
        height: kTsegSheContainerDim.dx,//Width
        width: kTsegSheContainerDim.dy,//Height
        child: SliderTheme(
          data: SliderThemeData(
            thumbShape: CustomSliderThumbRect(
              min:0,
              max:1,
              thumbRadius: kRoundedButtonRadius,
              thumbHeight: kTsegSheButtonDim.dy ,
              thumbWidth:  kTsegSheButtonDim.dx,
              image: _image,
            ),
            thumbColor: kTsegSheButtonColor,
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
              if (endValue == 0){
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
        ),
        color:kDeleteUndoButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(kRoundedButtonRadius)),
          side:BorderSide(
            color: kBottomRightButtonsBorderColor,
            width:kBottomRightButtonsBorderWidth
          )
        ),
      ),
    );
  }
}





