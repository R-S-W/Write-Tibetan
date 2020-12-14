
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

/// This is the private State class that goes with MyStatefulWidget.
class _TsegSheState extends State<TsegShe> {
  double restValue = 1;
  ui.Image _image;

  void initState(){ /////////////idk?? lookat the warning when you hover over initstate
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
    return Align(
        alignment: Alignment(1.0,1.0),
        child: RotatedBox(
          quarterTurns: 3,
          child: Container(
              height: 70,
              width: 70,
              // alignment: Alignment.bottomLeft,

              child: SliderTheme(
                  data: SliderThemeData(
                      thumbShape: CustomSliderThumbRect(
                          min:0,
                          max:1,
                          thumbRadius: 8,
                          thumbHeight: 50,
                          image: _image

                      )
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
        )
    );
  }
}



//DELETE UNDO BUTTON
class DeleteUndo extends StatefulWidget {

  final VoidCallback onPressed;
  final VoidCallback onSlid;
  DeleteUndo({Key key, 
    @required this.onPressed,
    @required this.onSlid})
      :super(key: key);

  @override
  _DeleteUndoState createState() => _DeleteUndoState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DeleteUndoState extends State<DeleteUndo> {
  double restValue = 1;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(1.0,1.0),
        child: Container(
          height: 70,
          width: 70,
          // alignment: Alignment.bottomLeft,

          child: SliderTheme(
              data: SliderThemeData(
                thumbShape: CustomSliderThumbRect(
                  min:0,
                  max:1,
                  thumbRadius: 8,
                  thumbHeight: 50,
                  text: "\u2190"
                )
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
        )
    );
  }
}









