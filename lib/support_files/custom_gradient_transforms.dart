import 'package:flutter/material.dart';
import 'dart:math' as m;
//used in animations of the step by step strokes in the CharacterPage widgets in
//Practice Mode
class GradientRotationReverse extends GradientTransform{
  /* To reverse the sweep angle, the starting angle alpha, the ending angle beta,
    and the center of the angle must be known.
    Reversing the angle requires one to invert the sweeping angle on the y-axis
    and rotate it back to its original position counterclockwise by an angular
    value.  That angular value is the sum of the alpha and beta.

    (Extra)
    Note that these transformations require the center of the sweeping angle to
    be at the origin of your coordinate system.  The .translate() lines in transform()
    ensure that the transformations are performed with the sweeping center as
    the origin.
  */
  double alpha = 0;
  double beta = 2*m.pi;
  Alignment center = Alignment(0.0,0.0);
  GradientRotationReverse(double this.alpha, double this.beta, Alignment this.center);

  @override
  Matrix4 transform(Rect bounds, {TextDirection textDirection}){
    assert(bounds!=null);

    Offset boxcenter = bounds.center;
    boxcenter+= Offset(boxcenter.dx*this.center.x,boxcenter.dy*this.center.y);
    final double angle = -alpha-beta;
    final double sinRadians = m.sin(angle);
    final double oneMinusCosRadians = 1 - m.cos(angle);
    final double originX = sinRadians * boxcenter.dy + oneMinusCosRadians * boxcenter.dx;
    final double originY = -sinRadians * boxcenter.dx + oneMinusCosRadians * boxcenter.dy;

    Matrix4 mat = Matrix4.identity();
    mat.translate(0.0,(1 + this.center.y)*bounds.height);
    mat.setEntry(1,1,-1);
    mat.translate(originX, originY);
    mat.rotateZ(angle);

    return mat;
  }

}