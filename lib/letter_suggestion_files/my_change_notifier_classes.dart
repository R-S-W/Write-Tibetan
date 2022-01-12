
import 'package:flutter/material.dart';
import 'tibetan_letter_finder.dart';
import '../letter_files/letter_encyclopedia.dart';



class AppBrain with ChangeNotifier {
  /* Communicates between stroke pad, suggestion bar, text display, and buttons.
  Contains the strokeList, suggestion list, and textDisplay sentence.  Is a
  change notifier.
   */

  //-----MEMBER VARIABLES-----
  List<List<Offset>> _strokeList = [];
  List<String> _suggestions = [];
  final LetterEncyclopedia _encyclopedia = LetterEncyclopedia();

  /*Since tibetan sentences are stacked, multiple adjacent UTF-16 characters are
   used to make 1 letter.  numTChars stores the length of each added chunk of
   unicode to properly delete an entire letter with deleteWord.
  */
  List<int> _numTChars = [];  // number of textdisplay characters
  String _textDisplaySentence = "";




  TextEditingController textDisplayController = TextEditingController();
  // int cursorCharIndex = 0; // The true index for the cursor in the text string,
  //since characters can be stacked and appear to have a smaller index.




  //------METHODS-------

  //ACCESSORS
  List<List<Offset>> getStrokeList() => _strokeList;
  List<String> getSuggestions()=> _suggestions;
  String getSuggestionAt(int index) => _suggestions[index];
  int getSuggestionsLength() => _suggestions.length;
  String getTextDisplaySentence() => textDisplayController.text;//_textDisplaySentence;

  //MODIFIERS



  void addWord (String aWord){
    String displayText = textDisplayController.text;
    // setCursorCharIndex(); // used to update the cursor index.
    List<int> selectionRange = getSelectionRange();
    int cursorCharIndex = selectionRange[0];
    int newCursorDisplayIndex = findCursorDisplayIndex(cursorCharIndex);

    //If there is a selection of text to be replaced,
    if (selectionRange[0]!=selectionRange[1]){
      int lidx = selectionRange[0];
      int ridx = selectionRange[1];
      int lDisplayIdx = findCursorDisplayIndex(lidx);
      int rDisplayIdx = findCursorDisplayIndex(ridx);

      textDisplayController.text = displayText.substring(0,lidx) + aWord;
      if (ridx < displayText.length) {
        textDisplayController.text += displayText.substring(ridx); //////////...
      }
      _numTChars[lDisplayIdx] = aWord.length;
      _numTChars = _numTChars.sublist(0, lDisplayIdx+1) + _numTChars.sublist(rDisplayIdx); /////....

    }else {//Insert character at the cursor
      if (displayText.length == 0 || cursorCharIndex == displayText.length) {
        textDisplayController.text += aWord;
      } else {
        textDisplayController.text = displayText.substring(0, cursorCharIndex) +
            aWord + displayText.substring(cursorCharIndex);
      }
      _numTChars.insert(newCursorDisplayIndex, aWord.length);
    }
    cursorCharIndex += aWord.length;
    //place the cursor in the correct position.
    textDisplayController.selection = TextSelection(
        baseOffset: cursorCharIndex, extentOffset: cursorCharIndex);

    print(
        'Stats: ${cursorCharIndex} ${newCursorDisplayIndex} ${textDisplayController
            .selection.baseOffset} ${textDisplayController.selection
            .extentOffset} ${_numTChars}');

    notifyListeners();
  }
  void deleteWord(){
    String displayText = textDisplayController.text;
    List<int> selectionRange = getSelectionRange();
    int lidx = selectionRange[0];
    int ridx = selectionRange[1];
    if ((0<lidx || lidx<ridx) && displayText.length>0) {

      int lDisplayIndex = findCursorDisplayIndex(lidx);
      int rDisplayIndex = findCursorDisplayIndex(ridx);
      if (lidx==ridx){
        lidx-=_numTChars[lDisplayIndex-1];
        lDisplayIndex-=1;
      }
      textDisplayController.text =
          displayText.substring(0,lidx)+displayText.substring(ridx);
      _numTChars = _numTChars.sublist(0, lDisplayIndex) + _numTChars.sublist(rDisplayIndex);
      textDisplayController.selection = TextSelection(baseOffset : lidx, extentOffset: lidx);

      print('Stats: ${lidx} ___ ${textDisplayController.selection.baseOffset} ${textDisplayController.selection.extentOffset} ${_numTChars}');

      notifyListeners();
    }
  }
  void clearSentence(){
    if (textDisplayController.text.length>0) {
      textDisplayController.text = '';
      _numTChars.clear();
      notifyListeners();
    }
  }


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

  void clearAllStrokesAndSuggestions() {
    _suggestions.clear();
    /*If suggestion bar is tapped, this will clear strokes.  This is also used
    in the undoslide button's onSlid function.*/
    _strokeList.clear();

    notifyListeners();
  }
  void _clearVerySmallStrokes(){
    /*remove the 1 or 2 point strokes from the strokeList, as they usually are
    errors.  Used in suggestLetters. */
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


  List<int> getSelectionRange(){
    int leftIndex = textDisplayController.selection.baseOffset;
    int rightIndex = textDisplayController.selection.extentOffset;
    print('selection range: $leftIndex, $rightIndex');
    leftIndex = leftIndex!=-1 ? leftIndex : 0;
    rightIndex = rightIndex!=-1 ? rightIndex : 0;
    return [leftIndex,rightIndex];
  }


  int findCursorDisplayIndex(int cursorCharIndex ){
    //helper function for addWord and deleteWord
    int s = 0;
    int i = 0;
    for ( ; s< cursorCharIndex && i< _numTChars.length ; i++ ){
      s+= _numTChars[i];
    }
    return i;
  }


  void printPathListString(){
    print(formatPathListToStr( strokeListToPathList(_strokeList)));
  }

}



//_____________________________________________________________________________-------------------------





//
//
// class S111uggestionToDisplay with ChangeNotifier {
//   //Class for the sentence displayed in the TextDisplay.
//
//   /*Since tibetan sentences are stacked, multiple adjacent UTF-16 characters are
//    used to make 1 letter.  numTChars stores the length of each added chunk of
//    unicode to properly delete an entire letter with deleteWord.
//   */
//   List<int> _numTChars = [];
//   String _textDisplaySentence = "";
//
//
//   String getTextDisplaySentence() => _textDisplaySentence;
//
//   void addWord (String aWord){
//     _textDisplaySentence+=aWord;
//     _numTChars.add(aWord.length);
//     notifyListeners();
//   }
//   void clearSentence(){
//     if (_textDisplaySentence.length>0) {
//       _textDisplaySentence = "";
//       _numTChars.clear();
//       notifyListeners();
//     }
//   }
//   void deleteWord(){
//     if (_textDisplaySentence.length>0) {
//       _textDisplaySentence = _textDisplaySentence.substring(0,
//           _textDisplaySentence.length - _numTChars.last);
//
//       _numTChars.removeLast();
//       notifyListeners();
//     }
//   }
// }
//
//
//
// //_______________________________________________________________
//
//
// class S111trokesToSuggestion with ChangeNotifier {
//   List<List<Offset>> _strokeList = [];
//   // List<String> TestSuggestions = "ཀ་ཏ་ད་ར་ཨ་པ་ཕ་ཆ་ཅ་ཇ་ས་ན་ཝ་ལ་ཐ་ས་ཤ་ཞ་ཉ་ང་མ་ཧ་ཧ་གུ་བོ་རི".split("་");
//   List<String> _suggestions = [];
//   final LetterEncyclopedia _encyclopedia = LetterEncyclopedia();
//
//
//
//   List<List<Offset>> getStrokeList() => _strokeList;
//   List<String> getSuggestions()=> _suggestions;
//   String getSuggestionAt(int index) => _suggestions[index];
//   int getSuggestionsLength() => _suggestions.length;
//
//
//
//   void addStroke(List<Offset> aStroke) {
//     _strokeList.add(aStroke);
//     suggestLetters();
//   }
//   void deleteStroke() {
//     if (_strokeList.length>0) {
//       _strokeList.removeLast();
//       suggestLetters();
//     }
//   }
//
//   void clearAllStrokesAndSuggestions() {
//     _suggestions.clear();
//     /*If suggestion bar is tapped, this will clear strokes.  This is also used
//     in the undoslide button's onSlid function.*/
//     _strokeList.clear();
//
//     notifyListeners();
//   }
//
//
//
//   void _clearVerySmallStrokes(){
//     /*remove the 1 or 2 point strokes from the strokeList, as they usually are
//     errors. */
//     for (int i = _strokeList.length-1 ; i>=0; i--){
//       if (_strokeList[i].length <3){
//         _strokeList.removeAt(i);
//       }
//     }
//   }
//
//   void suggestLetters() {
//     _clearVerySmallStrokes();
//
//     if (_strokeList.length >= 2) {
//       tibetanLetterFinder(_strokeList, _suggestions, _encyclopedia );
//
//       // print("suggestLetter Strokelist: ${StrokeList.length} ");
//       // Suggestions.shuffle();
//       // Suggestions = Suggestions.reversed;
//       // print("! $Suggestions !");
//
//     }else{
//       _suggestions.clear();
//     }
//     notifyListeners();
//   }
//
//
//
//   void printPathListString(){
//     print(formatPathListToStr( strokeListToPathList(_strokeList)));
//   }
//
// }




