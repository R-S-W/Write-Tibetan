// Constants for Dimensions of Widgets and Styles.
import 'package:flutter/material.dart';



//Basic Colors______________________________________________________
const Color kTRed = Color(0xff982929);
  // 0xafab0000 //Color(0xafab3333);
const Color kTWhite = Color(0xffececec);
  // 0xfff1f2ff
  //Color(0xffe8e8e8);
// 0xffdddddd // light off white   // 0xff5ebff2//light blue
// 0xffece6d7   // white with yellow

const Color kTGreen = Color(0xff317486);


//Main---------------------------------------------------------------
const Offset kScreenDim = Offset(414.0,896.0);


final ThemeData kMyAppThemeData = ThemeData(
  primarySwatch: Colors.blue,
);

const Color kAppBarBackgroundColor = Color(0xff1d6596);//Nice dark blue: Color(0xff075b8f)  // kTGreen;
// 0xff57c2ff
// 0xff4aa0d1
// 0xff4eade3 //subdued light blue
// 0xff2061c4 // dark blue
// Color(0xff57c2ff);

const double kMargin = 5.0;
const double kRoundedButtonRadius = 10;


//Text Display---------------------------------------------------------------
const double kTextMargin  = 10.0;
const double kTextDisplayHeight = 350.0;

const double kTextFontSize =45.0;


const Color kTextDisplayColor = kTWhite;


const TextStyle kTextDisplayStyle= TextStyle(
  fontSize: 50.0,
);


const Color  kCopyButtonColor = kTRed;

const Color kDeleteButtonColor = kCopyButtonColor;
// const TextStyle kTextDisplayButtonStyle = TextStyle(
//
// );




//Suggestion Bar----------------------------------------------------------------
const double kSuggestionBarHeight = 70;
const Color kSuggestionBarColor = kCopyButtonColor;
//Color(0xffab3333); //Color(0xdad52424);

const Offset kSuggestionListViewWidgetDim = Offset(55,65);

const kSuggestionTextColor = Color(0xffc8900a);
const TextStyle kSuggestionTextStyle =  TextStyle(
  fontSize: 39,
  color: kSuggestionTextColor,//Color(0xffa87d14),
);


const Color kSuggestionBarBorderlineColor= Color(0xffca7e08);//Color(0xff8d9ca3);

//Writing Stack---------------------------------------------------------------
const Offset kWritingStackDim = Offset(414.0, 310.0);
 //MediaQuery.of(context).size.width);

//Writing Pad
const Color kWritingPadColor = Color(0xff33798b   //0xff3a88a5 // nice bluegreen
);
// 0xffcab99e
// 0xffbaaf74 //khaki
// 0xff337687 //turquoise
////Color(0xff1a968c);
//0xff268e85
//2b9173
//17a495


//BottomRight Buttons-----------------------------------------------------------
// const Offset kRightmostButtonsDim = Offset(100.0, 280.0);
const Offset kRightmostButtonsDim = Offset(100.0, 200.0);
const Offset kTsegSheContainerDim = Offset(50.0,90);
const Offset kTsegSheButtonDim = Offset(50.0,80);
const Color kTsegSheButtonColor = Color(0xff465869);
const Color kTsegSheTextColor = Colors.white;

const Offset kDeleteUndoButtonDim = Offset(70,50);
const Color kDeleteUndoButtonColor = Color(0xff556b80);
const Color kDeleteUndoTextColor = Colors.white;

final Offset kEnterButtonDim = Offset(kRightmostButtonsDim.dx,50);
final Color kEnterButtonColor = Color(0xff98c6f2);
// final Offset kTsegSheButtonDim = Offset();

//TsegShe and  Delete Undo Constants are in the bottom_right_buttons.dart
// and custom_slider_thumb_rect.dart.




//Bottom Bar ---------------------------------------------------------------
const Color kBottomBarColor = Color(0xff280000);
//Color(0xff41351a);//Color(0xffa47a1f);



