import 'package:flutter/material.dart';
import 'dart:math' as m;
//used in animations of the step by step strokes in the CharacterPage widgets in
//Practice Mode
class GradientRotationReverse extends GradientTransform{
  double alpha = 0;
  double beta = 2*m.pi;
  GradientRotationReverse(double this.alpha, double this.beta);

  @override
  Matrix4 transform(Rect bounds, {TextDirection textDirection}){
    assert(bounds!=null);
    Matrix4 mat = Matrix4.identity();
    mat.setEntry(0,0,-1);
    mat.rotateZ(alpha+beta);
    return mat;
  }

}