


import 'package:flutter/material.dart';
import 'dart:math' as m;
import '../support_files/custom_gradient_transforms.dart';


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

const List<AlignmentGeometry> t2b =
  <AlignmentGeometry>[Alignment.topCenter, Alignment.bottomCenter];
const List<AlignmentGeometry> l2r = <AlignmentGeometry>[Alignment(-1,0.0), Alignment(1,0.0)];

const Map characterToGradientData = {
  "ཀ" : [
    [1,l2r],
    [1,t2b],
    [1,t2b],
    [1,t2b]
  ],
  "ཁ" : [
    [1,l2r],
    [1,t2b],
    [2,Alignment(.3, .4),[m.pi/2,2*m.pi]],
    [1,t2b],
  ],
  "ག" : [
    [1,l2r],
    [2,Alignment(-.3,.3),[m.pi/2,1.6*m.pi]],
    [1,t2b],
    [1,t2b]
  ],
  "ང" : [
    [1,l2r],
    [2,Alignment(0.0,.3),[m.pi*.6]]
  ],
  "ཅ" : [
    [1,l2r],
    [2,Alignment(-.5,.6),[],GradientRotationReverse],
    [2,Alignment(0.0,-.4),[],GradientRotationReverse],
  ],
  "ཆ" : [

  ],
  "ཇ" : [
    [1,l2r],
    [1,l2r],
    [2,Alignment.center,[m.pi/2]]
  ],
  "ཉ" : [
    [1,[Alignment(-.3,1),Alignment(.3,1)]],
    [2,Alignment(0.0,.7),[m.pi*.65,m.pi*1.3]],
    [2,Alignment(0.0,.7),[-m.pi*.34,m.pi*.34],GradientRotationReverse],
    [2,Alignment(0.0,0.0),[-.5*m.pi,m.pi*1.2],GradientRotationReverse]
  ],
  "ཏ" : [
    [1,l2r],
    [1,t2b],
    [2,Alignment(0.0,0.0),[-.5*m.pi,m.pi*1.2],GradientRotationReverse]
  ],
  "ཐ" : [
    [1,l2r],
    [2,Alignment(0.0,.3),[.7*m.pi]],
    [2,Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]],
    [1,t2b]
  ],
  "ད" : [
    [1,l2r],
    [2,Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]],
  ],
  "ན" : [],
  "པ" : [
    [1,l2r],
    [2,Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]],
    [1,t2b]    
  ],
  "ཕ" : [
    [1,l2r],
    [2,Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]],
    [1,t2b],
    [2,Alignment(.7,.8),[.5*m.pi,m.pi]]
  ],
  "བ" : [
    [1,l2r],
    [2,Alignment(0.0,0.0),[.7*m.pi,1.8*m.pi]],
    [1,t2b]    
  ],
  "མ" : [],
  "ཙ" : [
    [1,l2r],
    [2,Alignment(-.5,.6),[],GradientRotationReverse],
    [2,Alignment(0.0,-.4),[],GradientRotationReverse],
    [1,[Alignment(.7,.7), Alignment(1,1)]]
  ],
  "ཚ" : [],
  "ཛ" : [
    [1,l2r],
    [1,l2r],
    [2,Alignment.center,[m.pi/2]],
    [1,[Alignment(.7,.7), Alignment(1,1)]]
  ],
  "ཝ" : [
    [1,l2r],
    [2,Alignment(-.6,.7),[m.pi*.65,m.pi*1.3]],
    [2,Alignment(-.6,.7),[-m.pi*.34,m.pi*.34],GradientRotationReverse],
    [1,[Alignment(-.6,.7),Alignment(.4,.4)]],
    [2,Alignment(0.4,0.0),[.7*m.pi,1.8*m.pi]],
    [1,t2b]
  ],
  "ཞ" : [],
  "ཟ" : [
    [1,l2r],
    [1,l2r],
    [1,l2r],
    [1,t2b]
  ],
  "འ" : [
    [1,l2r],
    [2,Alignment(-.2,.6),[m.pi*.65,m.pi*1.3]],
    [2,Alignment(-.2,.6),[-m.pi*.34,m.pi*.34],GradientRotationReverse],
    [2,Alignment(.2,-.7),[.33*m.pi,.55*m.pi],GradientRotationReverse],
  ],
  "ཡ" : [
    [2,Alignment(-.4,-.4),[.6*m.pi,2.4*m.pi],GradientRotationReverse],
    [1,[Alignment(0,0),Alignment(1,-1)]],
    [1,t2b]
  ],
  "ར" : [
    [1,l2r],
    [1,t2b],
    [2,Alignment(0,-.5),[0,.7*m.pi],GradientRotationReverse]
  ],
  "ལ" : [
    [1,l2r],
    [2,Alignment(-.6,.7),[m.pi*.65,m.pi*1.3]],
    [2,Alignment(-.6,.7),[-m.pi*.34,m.pi*.34],GradientRotationReverse],
    [2,Alignment(.2,-.7),[.33*m.pi,.55*m.pi],GradientRotationReverse],
    [1,t2b]
  ],
  "ཤ" : [
    [1,l2r],
    [2,Alignment(0,0),[m.pi*.6]],
    [1,t2b],
    [1,l2r],
    [1,t2b]
  ],
  "ས" : [
    [1,l2r],
    [1,t2b],
    [1,l2r],
    [1,t2b]
  ],
  "ཧ" : [
    [1,l2r],
    [1,t2b],
    [2,Alignment(.3,-.6),[-.5*m.pi,.6*m.pi], GradientRotationReverse]
  ],
  "ཨ" : [
    [1,l2r],
    [2,Alignment(-.4,-.7),[.6*m.pi,2.4*m.pi], GradientRotationReverse],
    [1,[Alignment(-.1,.1),Alignment(.8,-.8)]],
    [1,t2b]
  ],
  "ཨི" : [],
  "ཨེ" : [],
  "ཨུ" : [],
  "ཨོ" : []
};