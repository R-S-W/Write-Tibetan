/*Class that holds all information on letters.  Takes letterData and creates:
1. letterDictionary from text name to Letter class
2. LetterPathsByStrokeCount: letterpaths of length n are at nth element of list.


Currently max # strokes is 9.

 */
import 'dart:core';
import 'letter_classes.dart';
import '../data_files/raw_letter_data.dart';

class LetterEncyclopedia {
  String letterData = rawLetterData;   ///bleh
  Map<String,Letter> letterDictionary = Map<String,Letter>();
  //Note:  LPBSC[1] = list of paths of 1 stroke.  LPBSC[0] =[].
  List<List<LetterPath>> letterPathsByStrokeCount = [];


  LetterEncyclopedia(){
    List<String> letterDataList = this.letterData.split("\n");

    for (int a =0; a <= 9; a++) { // Max # strokes = 9 !!!
      this.letterPathsByStrokeCount.add([]);
    }
    for (int i=0; i< letterDataList.length; i++){
      Letter aLetter = Letter(letterDataList[i]);
      this.letterDictionary[aLetter.tibetanLetter] = aLetter;

      // make StrokeCountDictionary.
      //for each stroke variation,
      for (int j=0; j< aLetter.strokeVariations.length; j++){
        this.letterPathsByStrokeCount[aLetter.numStrokesList[j]].add(
            LetterPath(
                aLetter.tibetanLetter + "," + aLetter.strokeVariations[j]) ) ;
      }
    }
  }

  Letter operator[](String key) =>  this.letterDictionary[key];
  void operator[]=(String key, Letter value)=> this.letterDictionary[key]=value;
}