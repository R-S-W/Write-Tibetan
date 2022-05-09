/*
  GradientData is a class that is used to hold the animation data for the
  DrawnStroke widget used in the PracticeCharacterPage.  Each GradientData
  instance holds information on how to animate a single stroke in a tibetan
  character.

  GradientData works with the ShaderMask widget in DrawnStroke.  DrawnStroke
  draws a single stroke of a tibetan character.  It does this by taking a
  white letter and coloring over it in black.  DrawnStroke uses Animation and
  AnimationController widgets that repeatedly color over the letter.

  This letter is colored in the ShaderMask widget.  The coloring is done by a
  Shader class.  This shader is created from the function in GradientData called
  shaderCallback.  ShaderCallback creates the coloring for only a single frame of
  the animation.  It keeps creating different shaders as the Animation widget
  progresses and rerenders the widget.

  The shaderCallback is the most important part of GradientData, as it is used
  in DrawnStroke.
*/
import 'package:flutter/material.dart';
import 'dart:math' as m;
import 'custom_gradient_transforms.dart';


class GradientData{
  List<AlignmentGeometry> linearStartEndPoints;
  AlignmentGeometry center;
  List<double> angleRange;
  bool isReversed;

  Function shaderCallback;
  GradientTransform gradientTransform;
  List<GradientData> multiStepList;

  //___________________CONSTRUCTORS____________________
  GradientData(){}


  GradientData.linear(this.linearStartEndPoints){
    this.shaderCallback = (animationVal) {
      return (rect)=>LinearGradient(
        colors: [Colors.black, Colors.white],
        begin: linearStartEndPoints[0],
        end: linearStartEndPoints[1],
        stops: [animationVal, animationVal]
      ).createShader(rect);
    };
  }


  GradientData.sweep(this.center, this.angleRange, {this.isReversed = false}){
    //Nullsafety for angleRange
    if (this.angleRange.length==0) {
      this.angleRange = [0,2*m.pi];
    }else if (this.angleRange.length ==1) {
      this.angleRange.add(2*m.pi);
    }
    //Ensure the angles are valid for the gradient
    if (this.angleRange[1]-this.angleRange[0] > 2*m.pi || this.angleRange[0]>4*m.pi
        || this.angleRange[1]>4*m.pi
        || m.min(this.angleRange[0],this.angleRange[1])>2*m.pi){
      this.angleRange = [0,2*m.pi];
    }
    //Sweep angle does not work for angle ranges that include 0 rad or 2pi rad.
    //This code makes it so that these angle ranges are drawn correctly
    // (by shifting the start and end angles and adding a rotation of 'phase'
    // radians)
    bool isBetween0 = this.angleRange[0]<0 && 0<this.angleRange[1];
    bool isBetween2pi = this.angleRange[0]<2*m.pi && 2*m.pi< this.angleRange[1];
    double phase = 0;
    if ( isBetween0 || isBetween2pi ) {
      if (isBetween2pi) {
        this.angleRange[0] -= 2 * m.pi;
        this.angleRange[1] -= 2 * m.pi;
      }
      phase = this.angleRange[0].abs();
      this.angleRange[0] += phase;
      this.angleRange[1] += phase;
    }
    //These Transforms are used to create shaderCallback.
    if(this.isReversed){//Reverse the angular range for cw or ccw strokes
      this.gradientTransform = GradientReversal(
        this.angleRange[0], this.angleRange[1], phase,this.center
      );
    }else if (phase>0){
      this.gradientTransform = GradientCenterRotation(-phase,this.center);
    }

    this.shaderCallback = (animationVal){
      return (rect)=>SweepGradient(
          colors: [Colors.black, Colors.white],
          center: center,
          startAngle: angleRange[0],
          endAngle: angleRange[1],
          stops: [ animationVal, animationVal],
          transform: this.gradientTransform
      ).createShader(rect);
    };
  }


  /*
  Multistep is used when a step-by-step character has a complex animation
  where the above animations are not sufficient.  multiStep takes a list of
  GradientData widgets with linear or sweep animations and uses each of them
  in its shaderCallback.

  ShaderCallback is yet another curried function that now takes stepIdx, the
  index of the current sub stroke that is drawn in DrawnStroke.  Using stepIdx,
  multiStep returns the shaderCallback of the corresponding GradientData in
  multiStepList.

  Warning: MultiStep is not created to handle passing MultiStep GradientDatas in
  multiStepList.

  (Extra)
  The reason why multiStep passes in
  this.multiStepList.length*animationVal-stepIdx
  into the shaderCallback of the GradientData in multiStepList instead of just
  animationVal is because of how DrawnStroke animates multiStep gradient
  animations.  In DrawnStroke, the animationVal goes from 0 to 1 normally, but
  subdivides the time taken equally between all steps.  (Ex.  a step-by-step
  character composed of 2 sub strokes has the DrawnStroke widget animate the
  first sub stroke from 0<animationVal<.5, and the second sub stroke from
  .5< animationVal <1.
  The expression that multiStep passes in ensures that the sub stroke will
  be animated within the allotted time in DrawnStroke.
  */
  GradientData.multiStep(List<GradientData> this.multiStepList){
    this.shaderCallback = (stepIdx,animationVal){
      return this.multiStepList[stepIdx].shaderCallback(
          this.multiStepList.length * animationVal - stepIdx
      );
    };
  }
}