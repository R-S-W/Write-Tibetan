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
  "ན" : "D \u00c0E ",
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
  "ས" : "\u00a1\u00a2\u00a3\u00a4",
  "ཧ" : "\u00a5\u00a6\u00a7",
  "ཨ" : "\u00a8\u00a9\u00aa\u00ab",
  "ཨི" :"\u00ab\u00ac",
  "ཨེ" :"\u00ab\u00ae",
  "ཨུ" :"\u00ab\u00b0",
  "ཨོ" :"\u00ab\u00af",
};



Function chaShaderCallback(animationVal){
  return (rect)=>SweepGradient(
      colors: [Colors.black, Colors.white,Colors.white,Colors.black],
      center: Alignment.center,
      // startAngle: angleRange[0],
      // endAngle: angleRange[1],
      stops: [ animationVal-.1, animationVal-.1,animationVal+.1,animationVal+.1],
      transform: null
  ).createShader(rect);

}




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
const List<AlignmentGeometry> t2b20_ =<AlignmentGeometry>[Alignment(.0,-.6), Alignment(.0,1.0)];
const List<AlignmentGeometry> l2r15_ = <AlignmentGeometry>[Alignment(-.7,0.0), Alignment(1,0.0)];
class GradientData{
  List<AlignmentGeometry> linearStartEndPoints;
  GradientTransform gradientTransform;
  AlignmentGeometry center;
  List<double> angleRange;

  bool isReversed;
  Function shaderCallback;
  List<GradientData> multiStepList;

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
    //This code makes it so that these angle ranges are drawn correctly by
    //shifting the start and end angles and adding a rotation of 'phase' radians.
    bool isBetween0 = this.angleRange[0]<0 && 0<this.angleRange[1];
    bool isBetween2pi = this.angleRange[0]<2*m.pi && 2*m.pi< this.angleRange[1];
    double phase = 0;

    if ( isBetween0 || isBetween2pi ){
      if (isBetween2pi){
        this.angleRange[0]-=2*m.pi;
        this.angleRange[1]-=2*m.pi;
      }
      phase = this.angleRange[0].abs();
      this.angleRange[0]+=phase;
      this.angleRange[1]+=phase;
    }
    // print([this.angleRange, phase]);


    if(this.isReversed){
      this.gradientTransform = GradientReversal(this.angleRange[0],this.angleRange[1],phase,this.center);
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



  GradientData.multiStep(List<GradientData> this.multiStepList){
    this.shaderCallback = (stepIdx,animationVal){
      return this.multiStepList[stepIdx].shaderCallback(
        this.multiStepList.length * animationVal - stepIdx
      );
    }
  }
}

Map characterToGradientData = {
  "ཀ" : [
    GradientData.linear(l2r),
    GradientData.linear(t2b20_),
    GradientData.linear(t2b20_),
    GradientData.linear(t2b20_)
  ],
  "ཁ" : [
    GradientData.linear(l2r),
    GradientData.linear(t2b20_),
    GradientData.sweep(Alignment(.5,-.4),[.4*m.pi,1.0*m.pi],isReversed: true),
    GradientData.linear(t2b20_),
  ],
  "ག" : [
    GradientData.linear(l2r),
    GradientData.sweep(Alignment(.1,-.25),[.3*m.pi,1.1*m.pi],isReversed: true),
    GradientData.linear(t2b20_),
    GradientData.linear(t2b20_)
  ],
  "ང" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(0.0,-.3),[m.pi*.2,1.1*m.pi], isReversed: true)
  ],
  "ཅ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(-.3,-.35),[-.25*m.pi,.9*m.pi]),
    GradientData.sweep(Alignment(0.0,.0),[-.65*m.pi,1.3*m.pi]),
  ],
  "ཆ" : [
    GradientData.linear(l2r),
    // GradientData(chaShaderCallback)
  ],
  "ཇ" : [
    GradientData.linear(l2r15_),
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(0,-.25),[.2*m.pi,1.8*m.pi],isReversed:true)
  ],
  "ཉ" : [
    GradientData.linear([Alignment(-.8,.0),Alignment(.8,.0)]),
    GradientData.sweep(Alignment(0.0,-.3),[m.pi*.66,m.pi*1.2],isReversed:true),
    GradientData.sweep(Alignment(0.0,-.3),[-m.pi*.34,m.pi*.34]),
    GradientData.sweep(Alignment(0.2,0.1),[.6*m.pi,m.pi*2.6])
  ],
  "ཏ" : [
    GradientData.linear(l2r15_),
    GradientData.linear(t2b20_),
    GradientData.sweep(Alignment(0.0,0.0),[-.95*m.pi,m.pi*.6])
  ],
  "ཐ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(0.0,-.3),[0.0,1.3*m.pi],isReversed:true),
    GradientData.sweep(Alignment(-.27,-0.02),[.1*m.pi,1.3*m.pi],isReversed: true),
    GradientData.linear(t2b20_)
  ],
  "ད" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(1.2,-0.22),[.5*m.pi,1.15*m.pi],isReversed: true),
  ],
  "ན" : [
    GradientData.linear(l2r15_),
    GradientData.multiStep([
      GradientData.linear([Alignment(.0,-.4),Alignment(.0,.1)]),
      GradientData.sweep(Alignment(.24,-.08),[.457*m.pi,2.456*m.pi])
    ]),
  ],
  "པ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(0.8,-0.25),[.5*m.pi,1.2*m.pi],isReversed:true),
    GradientData.linear(t2b20_)
  ],
  "ཕ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(0.8,-0.25),[.5*m.pi,1.2*m.pi],isReversed:true),
    GradientData.linear(t2b20_),
    GradientData.sweep(Alignment(.7,.0),[1.1*m.pi,1.5*m.pi],isReversed: true)
  ],
  "བ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(1.0,-.8),[.5*m.pi,.85*m.pi],isReversed: true),
    GradientData.linear(t2b20_)
  ],
  "མ" : [],
  "ཙ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(-.3,-.35),[-.25*m.pi,.9*m.pi]),
    GradientData.sweep(Alignment(0.0,.0),[-.65*m.pi,1.3*m.pi]),
    GradientData.linear([Alignment(.3,-.5), Alignment(1,-.7)])
  ],
  "ཚ" : [],
  "ཛ" : [
    GradientData.linear(l2r15_),
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(0,-.25),[.2*m.pi,1.8*m.pi],isReversed:true),
    GradientData.linear([Alignment(.3,-.5), Alignment(1,-.7)])
  ],
  "ཝ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(-.4,-.3),[m.pi*.55,m.pi*1.2],isReversed:true),
    GradientData.sweep(Alignment(-.4,-.3),[-m.pi*.34,m.pi*.34]),
    GradientData.linear([Alignment(-.6,-.45),Alignment(.4,.35)]),
    GradientData.sweep(Alignment(1.0,-.45),[.5*m.pi,.9*m.pi]),
    GradientData.linear(t2b20_)
  ],
  "ཞ" : [],
  "ཟ" : [
    GradientData.linear(l2r15_),
    GradientData.linear(l2r15_),
    GradientData.linear(l2r15_),
    GradientData.linear(t2b20_)
  ],
  "འ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(.0,-.3),[m.pi*.65,m.pi*1.3],isReversed : true),
    GradientData.sweep(Alignment(.0,-.3),[-m.pi*.34,m.pi*.34]),
    GradientData.sweep(Alignment(-.2,.7),[1.5*m.pi,1.8*m.pi]),
  ],
  "ཡ" : [
    GradientData.sweep(Alignment(-.4,-.3),[1.65*m.pi,3.42*m.pi],isReversed:   true),
    GradientData.sweep(Alignment(-1.0,.8),[1.6*m.pi,1.8*m.pi]),
    GradientData.linear(t2b20_)
  ],
  "ར" : [
    GradientData.linear(l2r15_),
    GradientData.linear(t2b20_),
    GradientData.sweep(Alignment(0,1.0),[1.3*m.pi,1.7*m.pi])
  ],
  "ལ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(-.3,-.25),[m.pi*.55,m.pi*1.34],isReversed:true),
    GradientData.sweep(Alignment(-.3,-.25),[-.4*m.pi,.4*m.pi]),
    GradientData.sweep(Alignment(-.25,1.0),[1.5*m.pi,1.7*m.pi]),
    GradientData.linear(t2b20_)
  ],
  "ཤ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(0,-.25),[m.pi*.15,1.4*m.pi],isReversed:true),
    GradientData.linear(t2b20_),
    GradientData.linear(l2r15_),
    GradientData.linear(t2b20_)
  ],
  "ས" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(.0,-.1),[.5*m.pi,1.4*m.pi],isReversed: true),
    GradientData.linear([Alignment(-.4,-.45),Alignment(.6,.3)]),
    GradientData.linear(t2b20_)
  ],
  "ཧ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(.4,-.15),[.5*m.pi,1.3*m.pi],isReversed:true),
    GradientData.sweep(Alignment(.0,.25),[-.6*m.pi,.6*m.pi])
  ],
  "ཨ" : [
    GradientData.linear([Alignment(-.35,0),Alignment(.35,0)]),
    GradientData.sweep(Alignment(-.6,-.2),[-.4*m.pi,1.55*m.pi]),
    GradientData.linear([Alignment(.0,-.5),Alignment(.75,.2)]),
    GradientData.linear(t2b20_)
  ],
  "ཨི" : [
    GradientData.linear([Alignment(.0,.9),Alignment.bottomCenter]),
    GradientData.sweep(Alignment(-.17,-.7),[.33*m.pi,2.32*m.pi])
  ],
  "ཨེ" : [
    GradientData.linear([Alignment(.0,.9),Alignment.bottomCenter]),
    GradientData.sweep(Alignment(-1.0,.45),[1.5*m.pi,1.75*m.pi])
  ],
  "ཨུ" : [
    GradientData.linear([Alignment(.0,.9),Alignment.bottomCenter]),
    GradientData.sweep(Alignment(.28,.37),[1.4*m.pi,3.25*m.pi])
  ],
  "ཨོ" : [
    GradientData.linear([Alignment(.0,.9),Alignment.bottomCenter]),
    GradientData.linear(l2r)
  ]
};