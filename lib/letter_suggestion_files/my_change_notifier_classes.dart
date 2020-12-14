
import 'package:flutter/material.dart';
import 'tibetan_letter_finder.dart';
import '../letter_files/letter_encyclopedia.dart';

class SuggestionToDisplay with ChangeNotifier {
  //Class for the sentence displayed in the TextDisplay.

  /*Since tibetan sentences are stacked, multiple adjacent UTF-16 characters are
   used to make 1 letter.  numTChars stores the length of each added chunk of
   unicode to properly delete an entire letter with deleteWord.
  */
  List<int> _numTChars = [];
  String _textDisplaySentence = "";


  String getTextDisplaySentence() => _textDisplaySentence;

  void addWord (String aWord){
    _textDisplaySentence+=aWord;
    _numTChars.add(aWord.length);
    notifyListeners();
  }
  void clearSentence(){
    if (_textDisplaySentence.length>0) {
      _textDisplaySentence = "";
      _numTChars.clear();
      notifyListeners();
    }
  }
  void deleteWord(){
    if (_textDisplaySentence.length>0) {
      _textDisplaySentence = _textDisplaySentence.substring(0,
          _textDisplaySentence.length - _numTChars.last);

      _numTChars.removeLast();
      notifyListeners();
    }
  }
}



//_______________________________________________________________


class StrokesToSuggestion with ChangeNotifier {
  List<List<Offset>> _strokeList = [];
  // List<String> TestSuggestions = "ཀ་ཏ་ད་ར་ཨ་པ་ཕ་ཆ་ཅ་ཇ་ས་ན་ཝ་ལ་ཐ་ས་ཤ་ཞ་ཉ་ང་མ་ཧ་ཧ་གུ་བོ་རི".split("་");
  List<String> _suggestions = [];
  final LetterEncyclopedia _encyclopedia = LetterEncyclopedia();



  List<List<Offset>> getStrokeList() => _strokeList;
  List<String> getSuggestions()=> _suggestions;
  String getSuggestionAt(int index) => _suggestions[index];
  int getSuggestionsLength() => _suggestions.length;



  void addStroke(List<Offset> aStroke) {
    _strokeList.add(aStroke);
    suggestLetters();
  }
  void deleteStroke() {
    if (_strokeList.length>0) {
      _strokeList.removeLast();
      suggestLetters();
    }
  }

  void clearAll() {
    _suggestions.clear();
    /*If suggestion bar is tapped, this will clear strokes.  This is also used
    in the undoslide button's onSlid function.*/
    _strokeList.clear();

    notifyListeners();
  }



  void _clearVerySmallStrokes(){
    /*remove the 1 or 2 point strokes from the strokeList, as they usually are
    errors. */
    for (int i = _strokeList.length-1 ; i>=0; i--){
      if (_strokeList[i].length <3){
        _strokeList.removeAt(i);
      }
    }
  }

  void suggestLetters() {
    _clearVerySmallStrokes();

    if (_strokeList.length >= 2) {
      tibetanLetterFinder(_strokeList, _suggestions, _encyclopedia );

      // print("suggestLetter Strokelist: ${StrokeList.length} ");
      // Suggestions.shuffle();
      // Suggestions = Suggestions.reversed;
      // print("! $Suggestions !");

    }else{
      _suggestions.clear();
    }
    notifyListeners();
  }



  void printPathListString(){
    print(formatPathListToStr( strokeListToPathList(_strokeList)));
  }

}
