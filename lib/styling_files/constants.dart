// Constants for Dimensions of Widgets and Styles.
import 'package:flutter/material.dart';


//All measurements are not the actual pixel size of the objects on the app.
//These are measurements on a screen of width 414 logical pixels.

//Used to scale the app for different screen resolutions.
const double kDevScreenWidth = 414.0*  1/ 1;
List<String> kAlphabet= ["ཀ","ཁ","ག","ང","ཅ","ཆ","ཇ","ཉ","ཏ","ཐ","ད","ན","པ","ཕ",
  "བ","མ","ཙ","ཚ","ཛ","ཝ","ཞ","ཟ","འ","ཡ","ར","ལ","ཤ","ས","ཧ","ཨ","ཨི","ཨུ","ཨེ","ཨོ"];


//Basic Colors______________________________________________________
const Color kTRed = Color(0xff982929);
const Color kTWhite = Color(0xffececec);
const Color kTGreen = Color(0xff317486);

//Fonts________________________________________________________________
const String kSairaCondensed = 'Saira_Condensed';
const String kShipporiAntiqueB1 = 'ShipporiAntiqueB1';
const String kMohave = 'Mohave';
const String kSFPro = 'SF_Pro';
const String kNotoSansTibetanStroke = 'NotoSansTibetanStroke';
const String kTib = 'Tib';


//General Constants____________________________________________________
const Color kButtonTextColor = Colors.white;
const double kButtonTextSize = 19;
const double kMargin = 9.0;




//Start Page______________________________________________
const kModeButtonTextStyle = TextStyle(
  color:Color(0xffeca444),
  fontFamily:kMohave,
  fontSize: 55,
  fontWeight: FontWeight.w700
);



//Main---------------------------------------------------------------
const Offset kScreenDim = Offset(414.0,896.0);
final ThemeData kMyAppThemeData = ThemeData(
  primarySwatch: Colors.blue,
);
const Color kAppBarBackgroundColor = Color(0xff1d6596);
const double kTopBarHeight = 40;
const double kRoundedButtonRadius = 16.5;


const Color kInfoScreenBackgroundColor = Color(0x3B000000);
const TextStyle kInfoScreenTextStyle = TextStyle(
  fontFamily: kSFPro,
  fontSize: 23,
  color: kTWhite,
);

const double kTrimHeight = 3.5;


//Practice Mode
double kPracticeCharStrokeSize = 300;

const Color kPracticeCharacterPageCanvasColor = Color(0xffcfcfcf);



//Text Display---------------------------------------------------------------
const double kTextMargin  = 10.0;
// const double kTextDisplayHeight = 350.0;
const Color kTextDisplayColor = kTWhite;

const double kTextFontSize =45.0;
const double kEstLineHeight = 54.0; // Pixel height of line of text at font size of 45

const Color kTextDisplayButtonRowBackgroundColor = Color(0xff802222);
const Color  kCopyButtonColor = kTRed;
const Color kDeleteButtonColor = kCopyButtonColor;


const TextStyle kTextDisplayButtonTextStyle = TextStyle(
  fontFamily: kShipporiAntiqueB1,
  fontSize: 17.5,
  color: kButtonTextColor,
  letterSpacing: -.5,
  height:1.2
);

const Size kTextDisplayButtonSize = Size(80,60);



//Suggestion Bar----------------------------------------------------------------
const double kSuggestionBarHeight = 70;
const double kSuggestionBarHeightP = .169;
const Offset kSuggestionListViewWidgetDim = Offset(55,65);
const Offset kSuggestionListViewWidgetDimP = Offset(.133,.157);

const Color kSuggestionBarColor = kCopyButtonColor;
const kSuggestionTextColor = Color(0xffc8900a);
const TextStyle kSuggestionTextStyle =  TextStyle(
  fontSize: 39,
  fontFamily: kTib,
  color: kSuggestionTextColor,
);

const Color kSuggestionBarBorderlineColor1 = Color(0xffca7e08);
const Color kSuggestionBarBorderlineColor2 = Color(0xffbf7709);


//Writing Stack---------------------------------------------------------------
const Offset kWritingStackDim = Offset(414.0, 310.0);


//Writing Pad------------------------------------------------------------------
const Color kWritingPadColor = Color(0xff2f6b7e);
const double kBottomButtonsHeight = 50;

const double kBrushSize = 3.7;
const Color kBrushColor = kTWhite;


//BottomRight Buttons-----------------------------------------------------------

//TsegShe and  Delete Undo Constants are in the bottom_right_buttons.dart
// and tseg_she_thumb_shape.dart.

const Offset kRightmostButtonsDim = Offset(100.0, 200.0);

const Offset kTsegSheContainerDim = Offset(50.0,115);
const Offset kTsegSheButtonDim = Offset(50.0,80);
const Color kTsegSheButtonColor = Color(0xff364962);

const Color kBottomRightButtonsBorderColor = Color(0x86ffffff);
const double kBottomRightButtonsBorderWidth = 1.75;

const Offset kDeleteUndoButtonDim = Offset(70,50);
const Color kDeleteUndoButtonColor =  Color(0xff416688);
const Color kDeleteUndoTextColor = Colors.white;

final Offset kEnterButtonDim =
  Offset(kRightmostButtonsDim.dx,kBottomButtonsHeight);
final Color kEnterButtonColor =Color(0xffc19140);




//SpaceBar--------------------------------------------------------------------
final Offset kSpaceButtonDim = Offset(kRightmostButtonsDim.dx,kBottomButtonsHeight);
final Color kSpacebarColor = Color(0xff4f86c1);



//Bottom Bar ---------------------------------------------------------------
//  (this is not BottomButton)
const Color kBottomBarColor = Color(0xff000000);