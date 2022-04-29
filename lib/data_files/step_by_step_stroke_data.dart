/*
  This file has data for the CharacterPage and DrawnStroke widgets of the
  drawn characters in Practice Mode.
 */


import 'package:flutter/material.dart';
import 'dart:math' as m;
import '../support_files/custom_gradient_transforms.dart';

//Map that converts the tibetan character into the step by step characters
//That appear in the custom font, NotoSansTibetanStroke. Each character in each
//Map value represents a step in drawing the picture of the character in the key
const Map<String,String> characterToStrokeUnicode = <String,String>{
  "ཀ" : "!\"#\$",
  "ཁ" : "%&\'(",
  "ག" : ")*+,",
  "ང" : "-.",
  "ཅ" : "/01",
  "ཆ" : "23",
  "ཇ" : "456",
  "ཉ" : "789:",
  "ཏ" : ";<=",
  "ཐ" : ">?@A",
  "ད" : "BC",
  "ན" : "DE",
  "པ" : "FGH",
  "ཕ" : "IJKL",
  "བ" : "MNO",
  "མ" : "PQR",
  "ཙ" : "STUV",
  "ཚ" : "WXY",
  "ཛ" : "Z[\\]",
  "ཝ" : "^_`abc",
  "ཞ" : "def",
  "ཟ" : "ghij",
  "འ" : "klmn",
  "ཡ" : "opq",
  "ར" : "rst",
  "ལ" : "uvwxy",
  "ཤ" : "z{|}~",
  "ས" : "i\u00a2\u00a3\u00a4",
  "ཧ" : "\u00a5\u00a6\u00a7",
  "ཨ" : "\u00a8\u00a9\u00aa\u00ab",
  "ཨི" :"\u00ac",
  "ཨེ" :"\u00ad",
  "ཨུ" :"\u00ae",
  "ཨོ" :"\u00af",
};



/*
  GradientData is a class made to contain all the data for the Gradient used in
  animation, as well as the function "shaderCallback" that is used in the
  ShaderMask widget inside DrawnStroke.
  (Extra)
  This function returns a curried function that ShaderMask actually uses.  This
  is because the Animation class
*/
const List<AlignmentGeometry> t2b =
  <AlignmentGeometry>[Alignment.topCenter, Alignment.bottomCenter];
const List<AlignmentGeometry> l2r = <AlignmentGeometry>[Alignment(-1,0.0), Alignment(1,0.0)];

class GradientData{
  List<AlignmentGeometry> linearStartEndPoints;
  GradientTransform gradientTransform;
  AlignmentGeometry center;
  List<double> angleRange;
  bool isReversed;
  Function shaderCallback;

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
    if (this.angleRange.length==0) {
      this.angleRange = [0,2*m.pi];
    }else if (this.angleRange.length ==1) {
      this.angleRange.add(2*m.pi);
    }
    this.gradientTransform = (this.isReversed) ?
      GradientRotationReverse(this.angleRange[0],this.angleRange[1],this.center) : null;

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

  //Helper function that takes the gradientData and creates a callback for the
  //ShaderMask widget in DrawnStroke

// Function generateShaderCallback(){
  //
  //   if (_gradientType == 1) { //is a Linear Gradient
  //     return (animationVal) {
  //       return (rect)=>LinearGradient(
  //           colors: [Colors.black, Colors.white],
  //           begin: linearStartEndPoints[0],
  //           end: linearStartEndPoints[1],
  //           stops: [animationVal, animationVal]
  //       ).createShader(rect);
  //     };
  //
  //   }else if (_gradientType == 2) { //Is a sweep gradient
  //     return (animationVal){
  //       return (rect)=>SweepGradient(
  //           colors: [Colors.black, Colors.white],
  //           center: center,
  //           startAngle: angleRange[0],
  //           endAngle: angleRange[1],
  //           stops: [ animationVal, animationVal],
  //           transform: gradientTransform
  //       ).createShader(rect);
  //     };
  //
  //   }else {//Default
  //     print('to default');
  //     return (animationVal){
  //       return (rect)=>LinearGradient(
  //           colors: [Colors.black, Colors.white],
  //           stops: [animationVal,animationVal]
  //       ).createShader(rect);
  //     };
  //   }
  // }
  //

}

Map characterToGradientData = {
  "ཀ" : [
    GradientData.linear(l2r),
    GradientData.linear(t2b),
    GradientData.linear(t2b),
    GradientData.linear(t2b)
  ],
  "ཁ" : [
    GradientData.linear(l2r),
    GradientData.linear(t2b),
    // GradientData.sweep(Alignment(.3, .4),[m.pi/2,2*m.pi]),
    GradientData.sweep(Alignment(-.5,.7),[0,.6*m.pi],isReversed: true),
    GradientData.linear(t2b),
  ],
  "ག" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(-.3,.3),[m.pi/2,1.6*m.pi]),
    GradientData.linear(t2b),
    GradientData.linear(t2b)
  ],
  "ང" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(0.0,.3),[m.pi*.6])
  ],
  "ཅ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(-.5,.6),[],isReversed : true),
    GradientData.sweep(Alignment(0.0,-.4),[],isReversed : true),
  ],
  "ཆ" : [

  ],
  "ཇ" : [
    GradientData.linear(l2r),
    GradientData.linear(l2r),
    GradientData.sweep(Alignment.center,[m.pi/2])
  ],
  "ཉ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(0.0,.7),[m.pi*.65,m.pi*1.3]),
    GradientData.sweep(Alignment(0.0,.7),[-m.pi*.34,m.pi*.34],isReversed : true
),
    GradientData.sweep(Alignment(0.0,0.0),[-.5*m.pi,m.pi*1.2],isReversed : true
)
  ],
  "ཏ" : [
    GradientData.linear(l2r),
    GradientData.linear(t2b),
    GradientData.sweep(Alignment(0.0,0.0),[-.5*m.pi,m.pi*1.2],isReversed : true
)
  ],
  "ཐ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(0.0,.3),[.7*m.pi]),
    GradientData.sweep(Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]),
    GradientData.linear(t2b)
  ],
  "ད" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]),
  ],
  "ན" : [],
  "པ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]),
    GradientData.linear(t2b)
  ],
  "ཕ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]),
    GradientData.linear(t2b),
    GradientData.sweep(Alignment(.7,.8),[.5*m.pi,m.pi])
  ],
  "བ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]),
    GradientData.linear(t2b)
  ],
  "མ" : [],
  "ཙ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(-.5,.6),[],isReversed : true
),
    GradientData.sweep(Alignment(0.0,-.4),[],isReversed : true
),
    GradientData.linear([Alignment(.7,.7), Alignment(1,1)])
  ],
  "ཚ" : [],
  "ཛ" : [
    GradientData.linear(l2r),
    GradientData.linear(l2r),
    GradientData.sweep(Alignment.center,[m.pi/2]),
    GradientData.linear([Alignment(.7,.7), Alignment(1,1)])
  ],
  "ཝ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(-.6,.7),[m.pi*.65,m.pi*1.3]),
    GradientData.sweep(Alignment(-.6,.7),[-m.pi*.34,m.pi*.34],isReversed : true
),
    GradientData.linear([Alignment(-.6,.7),Alignment(.4,.4)]),
    GradientData.sweep(Alignment(0.4,0.0),[.7*m.pi,1.8*m.pi]),
    GradientData.linear(t2b)
  ],
  "ཞ" : [],
  "ཟ" : [
    GradientData.linear(l2r),
    GradientData.linear(l2r),
    GradientData.linear(l2r),
    GradientData.linear(t2b)
  ],
  "འ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(-.2,.6),[m.pi*.65,m.pi*1.3]),
    GradientData.sweep(Alignment(-.2,.6),[-m.pi*.34,m.pi*.34],isReversed : true
),
    GradientData.sweep(Alignment(.2,-.7),[.33*m.pi,.55*m.pi],isReversed : true
),
  ],
  "ཡ" : [
    GradientData.sweep(Alignment(-.4,-.4),[.6*m.pi,2.4*m.pi],isReversed : true
),
    GradientData.linear([Alignment(0,0),Alignment(1,-1)]),
    GradientData.linear(t2b)
  ],
  "ར" : [
    GradientData.linear(l2r),
    GradientData.linear(t2b),
    GradientData.sweep(Alignment(0,-.5),[0,.7*m.pi],isReversed : true
)
  ],
  "ལ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(-.6,.7),[m.pi*.65,m.pi*1.3]),
    GradientData.sweep(Alignment(-.6,.7),[-m.pi*.34,m.pi*.34],isReversed : true
),
    GradientData.sweep(Alignment(.2,-.7),[.33*m.pi,.55*m.pi],isReversed : true
),
    GradientData.linear(t2b)
  ],
  "ཤ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(0,0),[m.pi*.6]),
    GradientData.linear(t2b),
    GradientData.linear(l2r),
    GradientData.linear(t2b)
  ],
  "ས" : [
    GradientData.linear(l2r),
    GradientData.linear(t2b),
    GradientData.linear(l2r),
    GradientData.linear(t2b)
  ],
  "ཧ" : [
    GradientData.linear(l2r),
    GradientData.linear(t2b),
    GradientData.sweep(Alignment(.3,-.6),[-.5*m.pi,.6*m.pi], isReversed : true
)
  ],
  "ཨ" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(-.4,-.7),[.6*m.pi,2.4*m.pi], isReversed : true
),
    GradientData.linear([Alignment(-.1,.1),Alignment(.8,-.8)]),
    GradientData.linear(t2b)
  ],
  "ཨི" : [],
  "ཨེ" : [],
  "ཨུ" : [],
  "ཨོ" : []
};