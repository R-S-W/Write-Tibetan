import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';

import 'app_logic/practice_mode_brain.dart';

class PracticeMode extends StatelessWidget {
  const PracticeMode({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => PracticeModeBrain(),
      child: Container(width: 100, height: 100, color: Colors.red)

    );
  }
}