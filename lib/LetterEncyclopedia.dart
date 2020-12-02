import 'dart:core';
import 'package:tibetan_handwriting_app/LetterClasses.dart';
import 'LetterData.dart';


class LetterEncyclopedia {
  String LetterData = letterData;   ///bleh
  Map<String,Letter> LetterDictionary = Map<String,Letter>();
  List<List<LetterPath>> LetterPathsByStrokeCount = [];     // LPBSC[1] = list of paths of 1 stroke.  LPBSC[0] =[]

  LetterEncyclopedia(){
    List<String> letterDataList = this.LetterData.split("\n");

    for (int a =0; a <= 9; a++) { ////////////////    ////the MAX # Strokes": = 9.
      this.LetterPathsByStrokeCount.add([]);
    }
    for (int i=0; i< letterDataList.length; i++){
      Letter aLetter = Letter(letterDataList[i]);
      this.LetterDictionary[aLetter.TibetanLetter] = aLetter;

      // make StrokeCountDictionary
      for (int j=0; j< aLetter.strokeVariations.length; j++){//for each stroke variation,
        this.LetterPathsByStrokeCount[aLetter.numStrokesList[j]].add( LetterPath( aLetter.TibetanLetter + "," + aLetter.strokeVariations[j]) ) ;
      }
    }
  }

  Letter operator[](String key) =>  this.LetterDictionary[key];
  void operator[]=(String key, Letter value) => this.LetterDictionary[key] = value;
}