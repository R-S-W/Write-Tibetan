import 'package:flutter/material.dart';
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';

class TsegSheSliderTrack extends RoundedRectSliderTrackShape {
  double scaleFactor;

  TsegSheSliderTrack({@required double this.scaleFactor}):super();

  Rect getPreferredRect({
    @required SliderThemeData sliderTheme,
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    print("${parentBox.size},  $offset");
    return Rect.fromLTWH(
      offset.dx + (kTsegSheButtonDim.dx / 2 + kRoundedButtonRadius) * this.scaleFactor,
      parentBox.size.height/2 + offset.dy - (sliderTheme.trackHeight / 2) * this.scaleFactor,
      parentBox.size.width - (kTsegSheButtonDim.dx + 2 * kRoundedButtonRadius) * this.scaleFactor,
      sliderTheme.trackHeight //*this.scaleFactor
    );
  }

}