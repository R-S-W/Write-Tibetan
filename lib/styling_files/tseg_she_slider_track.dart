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
    final double trackHeight = sliderTheme.trackHeight;
    final double bwidth =  kTsegSheButtonDim.dx+2*kRoundedButtonRadius;
    final double trackLeft = offset.dx + (bwidth)/2;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = pWidth - bwidth;
    return Rect.fromLTWH(trackLeft,trackTop, trackWidth, trackHeight);
  }
}