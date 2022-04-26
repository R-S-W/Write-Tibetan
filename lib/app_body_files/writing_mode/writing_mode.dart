import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD:lib/app_body_files/writing_mode/writing_mode.dart
import '../../app_logic/app_brain.dart';
import '../../main_body.dart';
=======
import '../app_logic/app_brain.dart';
import '../main_body.dart';
>>>>>>> 5b05839b042da42562c3cf4c792468202f95b23c:lib/writing_mode.dart
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';

class WritingMode extends StatelessWidget {
  const WritingMode({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenDimensions = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;

    //Screen dimensions multiplier
    double safeScreenWidth = screenDimensions.width-padding.left -padding.right;
    double safeScreenHeight= screenDimensions.height-padding.top-padding.bottom;
    double sdm = safeScreenWidth / kDevScreenWidth;
    screenDimensions*=sdm;

    return ChangeNotifierProvider(
      create:(context) => AppBrain(
          screenDims: screenDimensions,
          safeScreenDims: Size(safeScreenWidth, safeScreenHeight),
          safePadding: padding
      ),
      child: MainBody()
    );
  }
}