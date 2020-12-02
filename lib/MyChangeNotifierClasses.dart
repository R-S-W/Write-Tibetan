
import 'package:flutter/material.dart';
// import 'package:tibetan_handwriting_app/LetterClasses.dart';
import 'package:tibetan_handwriting_app/TibetanLetterFinder.dart';
import 'LetterEncyclopedia.dart';


class SuggestionToDisplay with ChangeNotifier {
  //Class for the sentence displayed in the TextDisplay.

  /*Since tibetan sentences are stacked, multiple adjacent UTF-16 characters are
   used to make 1 letter.  numTChars stores the length of each added chunk of
   unicode to properly delete an entire letter with deleteWord.
  */
  List<int> numTChars = [];
  String TextDisplaySentence = "";

  void addWord (String aWord){
    TextDisplaySentence+=aWord;
    numTChars.add(aWord.length);
    notifyListeners();
  }
  void clearSentence(){
    if (TextDisplaySentence.length>0) {
      TextDisplaySentence = "";
      numTChars.clear();
      notifyListeners();
    }
  }
  void deleteWord(){
    //simple version, may need to make it better
    if (TextDisplaySentence.length>0) {
      TextDisplaySentence = TextDisplaySentence.substring(0, TextDisplaySentence.length - numTChars.last);
      numTChars.removeLast();
      notifyListeners();
    }
  }
}



//_______________________________________________________________


class StrokesToSuggestion with ChangeNotifier {
  List<List<Offset>> StrokeList = [];
  // List<LetterPath>  AllLetterPaths ;// all the letter paths from the data.



  List<String> TestSuggestions = "ཀ་ཏ་ད་ར་ཨ་པ་ཕ་ཆ་ཅ་ཇ་ས་ན་ཝ་ལ་ཐ་ས་ཤ་ཞ་ཉ་ང་མ་ཧ་ཧ་གུ་བོ་རི".split("་");
  List<String> Suggestions = [];
  LetterEncyclopedia Encyclopedia = LetterEncyclopedia();
  // List<String> Suggestions = "ཀ་ཏ་ད་ར་ཨ་པ་ཕ་ཆ་ཅ་ཇ་ས་ན་ཝ་ལ་ཐ་ས་ཤ་ཞ་ཉ་ང་མ་ཧ་ཧ་གུ་བོ་རི".split("་");




  void addStroke(List<Offset> aStroke) {
    StrokeList.add(aStroke);
    suggestLetters();
  }
  void deleteStroke() {
    if (StrokeList.length>0) {
      StrokeList.removeLast();
      suggestLetters();
    }
  }

  void clearAll() {
    Suggestions.clear();
    StrokeList.clear(); //If suggestion bar is tapped, this will clear strokes.  This is also used in the undoslide button's onSlid function.

    notifyListeners();
  }


  void suggestLetters() {


    if (StrokeList.length >= 2) {
      TibetanLetterFinder(StrokeList, Suggestions, Encyclopedia );

      // Suggestions.add(TestSuggestions[(StrokeList.length -3)%TestSuggestions.length]);
      // print("suggestLetter Strokelist: ${StrokeList.length} ");

      // Suggestions.shuffle();
      // Suggestions = Suggestions.reversed;
      // print("! $Suggestions !");


    }else{
      Suggestions.clear();
    }

    // TibetanLetterFinder(StrokeList, Suggestions );

    notifyListeners();
  }

  void printPathListString(){
    print(formatPathListToStr( strokeListToPathList(StrokeList)));
  }



}
