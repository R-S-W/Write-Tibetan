import 'package:flutter/material.dart';
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';

class TsegSheSliderTrack extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    double pWidth = parentBox.size.width;
    double ptRatio = .5;
    double leftBuffer= pWidth*(1-ptRatio);
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx - kTsegSheButtonDim.dx/2;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    // return Rect.fromLTWH(0,0, pWidth/2, trackHeight);
    return Rect.fromLTWH(trackLeft,trackTop, pWidth, trackHeight);
  }
}