
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../styling_files/constants.dart';
import '../../../../styling_files/tseg_she_thumb_shape.dart';
import '../../../../styling_files/tseg_she_slider_track_shape.dart';



class TsegShe extends StatefulWidget {

  final VoidCallback onPressed;
  final VoidCallback onSlid;
  final double scaleFactor;

  TsegShe({Key key,
    @required this.onPressed, 
    @required this.onSlid,
    @required this.scaleFactor
  })
    :super(key: key);
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
    final ui.Codec codec = await ui.instantiateImageCodec(
      bytes,
      targetHeight: (36*widget.scaleFactor).toInt(),
      targetWidth: (68*widget.scaleFactor).toInt()
    );
    final ui.Image image=(await codec.getNextFrame()).image;
    setState(()=> _image=image);
  }
  

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        //Width and height are switched because the widget is rotated.
        height: kTsegSheContainerDim.dx*widget.scaleFactor,//Width
        width: kTsegSheContainerDim.dy * widget.scaleFactor,//Height
        child: SliderTheme(
          data: SliderThemeData(
            thumbShape: TsegSheThumbShape(
              min:0,
              max:1,
              thumbRadius: kRoundedButtonRadius,
              thumbHeight: kTsegSheButtonDim.dy,
              thumbWidth:  kTsegSheButtonDim.dx,
              image: _image,
              scaleFactor: widget.scaleFactor
            ),
            trackShape: TsegSheSliderTrackShape(scaleFactor:widget.scaleFactor),
            thumbColor: kTsegSheButtonColor,
            inactiveTrackColor: Color(0x00),
            activeTrackColor: Color(0x00),
            overlayColor: Colors.transparent
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
  final double scaleFactor;
  DeleteUndo({
    @required this.onPressed,
    @required this.onLongPress,
    @required this.scaleFactor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kDeleteUndoButtonDim.dx * this.scaleFactor,
      height: kDeleteUndoButtonDim.dy * this.scaleFactor,
      child: ElevatedButton(
        child: Text(
          "\u21BA",
          style:TextStyle(
            fontFamily: kSFPro,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: kDeleteUndoTextColor,
          ),
          textScaleFactor: this.scaleFactor,
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed,
        onLongPress:onLongPress,
        style: ElevatedButton.styleFrom(
          primary:kDeleteUndoButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kRoundedButtonRadius*this.scaleFactor)
            ),
            side:BorderSide(
              color: kBottomRightButtonsBorderColor,
              width:kBottomRightButtonsBorderWidth * this.scaleFactor
            )
          )
        ),
      ),
    );
  }
}





