import 'package:flutter/material.dart';
import 'dart:math' as m;
import '../support_files/gradient_data.dart';


const List<AlignmentGeometry> t2b =
<AlignmentGeometry>[Alignment.topCenter, Alignment.bottomCenter];
const List<AlignmentGeometry> l2r =
<AlignmentGeometry>[Alignment(-1,0.0), Alignment(1,0.0)];
const List<AlignmentGeometry> t2b20_ =
<AlignmentGeometry>[Alignment(.0,-.6), Alignment(.0,1.0)];
const List<AlignmentGeometry> l2r15_ =
<AlignmentGeometry>[Alignment(-.7,0.0), Alignment(1,0.0)];


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
    GradientData.multiStep([
      GradientData.linear([Alignment(.0,-1.0),Alignment(.0,.15)]),
      GradientData.sweep(Alignment(-.5,-.1),[],isReversed: true),
      GradientData.sweep(Alignment(.5,-.1),[m.pi,3*m.pi])

    ])
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
    GradientData.sweep(Alignment(-.27,-.02),[.1*m.pi,1.3*m.pi],isReversed:true),
    GradientData.linear(t2b20_)
  ],
  "ད" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(1.2,-.22),[.5*m.pi,1.15*m.pi],isReversed:true),
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
  "མ" : [
    GradientData.linear(l2r15_),
    GradientData.multiStep([
      GradientData.sweep(Alignment(-.4,-.15),[-.5*m.pi,.7*m.pi]),
      GradientData.sweep(Alignment(-.4,-.15),[.65*m.pi,2.25*m.pi])
    ]),
    GradientData.linear(t2b20_)
  ],
  "ཙ" : [
    GradientData.linear(l2r15_),
    GradientData.sweep(Alignment(-.3,-.35),[-.25*m.pi,.9*m.pi]),
    GradientData.sweep(Alignment(0.0,.0),[-.65*m.pi,1.3*m.pi]),
    GradientData.linear([Alignment(.3,-.5), Alignment(1,-.7)])
  ],
  "ཚ" : [

  ],
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
  "ཞ" : [
    GradientData.linear([Alignment(-.35,.0),Alignment(1.0,.0)]),
    GradientData.sweep(Alignment(.0,-.3),[.5*m.pi,1.33*m.pi],isReversed:true),
    GradientData.multiStep([
      GradientData.sweep(Alignment(.15,-.1),[-.4*m.pi,.7*m.pi]),
      GradientData.sweep(Alignment(.15,-.1),[.7*m.pi,2.4*m.pi]),
    ])
  ],
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
    GradientData.sweep(Alignment(-.4,-.3),[1.65*m.pi,3.42*m.pi],isReversed:true),
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