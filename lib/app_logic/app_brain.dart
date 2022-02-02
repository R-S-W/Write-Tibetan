import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:tibetan_handwriting_app_0_1/styling_files/constants.dart';
import 'package:tibetan_handwriting_app_0_1/support_files/linked_list.dart';
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

  /* TextEditingController controls the TextField in the TextDisplay
    widget.
    * textDisplayController.text  = text of TextDisplay
    * textDisplayController.selection = range of the highlighted text selection
        This attribute's .baseOffset and .extentOffset generally are the indices
        of where the selection begins and ends in the text.
    When updated, it updates the TextDisplay.  It is modified by addWord,
    deleteWord, and clearSentence.

    Similarly, textDisplayScrollController scrolls the TextDisplay.
  */
  TextEditingController textDisplayController = TextEditingController();
  ScrollController textDisplayScrollController = ScrollController();


  /* The textHistory contains the history of  string values of TextDisplay.
    Every change to TextDisplay adds a new element to textHistory.  The elements
    of textHistory are lists with three values: the first is the sentence, while
    the second is a _numTChars array that indicates the length of characters
    for each character in the sentence.  The third is a list of offsets of the
    beginning and end of the current text selection for the cursor.

    The textHistory length ranges from 1 to _maxTextHistoryLength.
    textHistory is altered by the undo() and updateTextHistory(). The last
    value represents the current state of the text in TextDisplay.
  */
  int _maxTextHistoryLength = 50;
  LinkedList _textHistory = LinkedList();
  LinkedListIterator _textHistoryItr;


  AppBrain() : super(){
    _textHistory.addLast(["",<int>[],[0,0]]);//Set initial state of _textHistory
    _textHistoryItr = LinkedListIterator(_textHistory);
  }



  //================================METHODS=====================================

  //-------------------------------ACCESSORS-----------------------------------
  List<List<Offset>> getStrokeList() => _strokeList;
  List<String> getSuggestions()=> _suggestions;
  String getSuggestionAt(int index) => _suggestions[index];
  int getSuggestionsLength() => _suggestions.length;
  String getTextDisplaySentence() => textDisplayController.text;



  List<int> _getSelectionRange(){//get range of highlighted text in TextDisplay
    //helper function of addWord and deleteWord
    int leftIndex = textDisplayController.selection.baseOffset;
    int rightIndex = textDisplayController.selection.extentOffset;
    leftIndex = leftIndex!=-1 ? leftIndex : 0;
    rightIndex = rightIndex!=-1 ? rightIndex : 0;
    return [leftIndex,rightIndex];
  }

  int _getCursorDisplayIndex(int cursorCharIndex){
    //using the index position of a character in TextDisplay text, get the
    // corresponding index of _numTChars.
    //helper function for addWord and deleteWord
    int s = 0;
    int i = 0;
    for ( ; s< cursorCharIndex && i< _numTChars.length ; i++ ){
      s+= _numTChars[i];
    }
    return i;
  }



  //---------------------------------MODIFIERS---------------------------------
  void addWord (String aWord){//Inserts/replaces word into text of TextDisplay
    String displayText = textDisplayController.text;
    List<int> selectionRange = _getSelectionRange();
    int cursorCharIndex = selectionRange[0]; //position in text
    //position in _numTChars
    int newCursorDisplayIndex = _getCursorDisplayIndex(cursorCharIndex);

    //Update text and _numTChar.
    //If there is a highlighted selection of text to be replaced,
    if (selectionRange[0]!=selectionRange[1]){
      int lidx = selectionRange[0];
      int ridx = selectionRange[1];
      int lDisplayIdx = _getCursorDisplayIndex(lidx);
      int rDisplayIdx = _getCursorDisplayIndex(ridx);

      textDisplayController.text = displayText.substring(0,lidx) + aWord;
      if (ridx < displayText.length) {
        textDisplayController.text += displayText.substring(ridx);
      }
      _numTChars[lDisplayIdx] = aWord.length;
      _numTChars = _numTChars.sublist(0, lDisplayIdx+1) +
          _numTChars.sublist(rDisplayIdx);
    }else {//Insert character at the cursor
      if (displayText.length == 0 || cursorCharIndex == displayText.length) {
        textDisplayController.text += aWord;
      } else {
        textDisplayController.text = displayText.substring(0, cursorCharIndex) +
            aWord + displayText.substring(cursorCharIndex);
      }
      _numTChars.insert(newCursorDisplayIndex, aWord.length);
    }

    //place the cursor in the correct position.
    cursorCharIndex += aWord.length;
    textDisplayController.selection = TextSelection(
        baseOffset: cursorCharIndex, extentOffset: cursorCharIndex);
    print("${getTextDisplaySentence()}, $_numTChars, ${_getSelectionRange()}");

    _handleScroll(cursorCharIndex);  //Scroll display if cursor is not visible
    _updateTextHistory();

    notifyListeners();
  }


  void deleteWord(){//Deletes words from TextDisplay.
    String displayText = textDisplayController.text;
    List<int> selectionRange = _getSelectionRange();
    int lidx = selectionRange[0];
    int ridx = selectionRange[1];
    //If text is nonempty and is a highlighted text selection or the cursor is
    // in the middle of the text,
    if ((0<lidx || lidx<ridx) && displayText.length>0) {
      int lDisplayIndex = _getCursorDisplayIndex(lidx);
      int rDisplayIndex = _getCursorDisplayIndex(ridx);
      if (lidx==ridx){//If we are deleting behind the cursor:
        lidx-=_numTChars[lDisplayIndex-1];
        lDisplayIndex-=1;
      }
      textDisplayController.text =
          displayText.substring(0,lidx)+displayText.substring(ridx);
      _numTChars =
          _numTChars.sublist(0,lDisplayIndex)+_numTChars.sublist(rDisplayIndex);
      textDisplayController.selection =
          TextSelection(baseOffset : lidx, extentOffset: lidx);

      //Scroll display if cursor is not visible
      _handleScroll(lidx);
      print("${getTextDisplaySentence()}, $_numTChars, ${_getSelectionRange()}");
      _updateTextHistory();

      // print('Stats: ${lidx} ___ ${textDisplayController.selection.baseOffset} ${textDisplayController.selection.extentOffset} ${_numTChars}');

      notifyListeners();
    }
  }


  void clearSentence(){//Clear TextDisplay
    if (textDisplayController.text.length>0) {
      textDisplayController.text = '';
      textDisplayController.selection =
          TextSelection(baseOffset: 0,extentOffset:0);
      _numTChars.clear();

      _updateTextHistory();
      notifyListeners();
    }
  }

  void _updateTextHistory(){
    //checks if lists have identical values
    Function isListsEqual = ListEquality().equals;
    //First, check if the text state has changed at all.
    var prevState = _textHistoryItr.currentValue;
    bool isModified = prevState[0] != getTextDisplaySentence() ||
      !isListsEqual(prevState[1],_numTChars) ||
      !isListsEqual(_getSelectionRange(),prevState[2]);

    //If the state was changed:
    if (isModified){
      //Clear the text states after the prevState
      _textHistoryItr.removeAfterCurrent();
      //Add the current state
      _textHistory.addLast( [
        getTextDisplaySentence(),
        <int>[..._numTChars],
        _getSelectionRange()
      ]);
      if (_maxTextHistoryLength < _textHistory.length){
        _textHistory.removeFirst();
      }
    }
  }


  void undo(){//Undo last change to TextDisplay
    if (!_textHistoryItr.isAtStart){
      _textHistoryItr.retreat(); //Point to previous state.
      var prevState = _textHistoryItr.currentValue;
      setTextState(prevState);  //Set the current state to the previous state.
      _handleScroll(prevState[2][0]);
      notifyListeners();
    }
  }


  void redo(){//Redo the last change to TextDisplay
    if (!_textHistoryItr.isAtEnd){
      _textHistoryItr.advance();
      var nextState = _textHistoryItr.currentValue;
      setTextState(nextState);
      _handleScroll(nextState[2][0]);
      notifyListeners();
    }
  }

  
  //Change the text and cursor selection in DisplayText as well as _numTChars.
  //newState is a list of this form:  [ String, <int>[], [int,int]  ].
  //Helper function to undo and redo.
  void setTextState(List newState){
    textDisplayController.text = newState[0];
    _numTChars = <int>[...newState[1]];
    textDisplayController.selection =
      TextSelection(baseOffset: newState[2][0], extentOffset: newState[2][1]);
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
    errors.  Helper function in suggestLetters. */
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


  //Helper function for _handleScroll
  double _calcCursorOffset(int numNewlines) => (numNewlines)*cLineHeight + 34;


  //Scrolls TextDisplay to keep cursor visible.
  void _handleScroll( int cursorCharIndex){
    int numNewlinesBeforeCursor =
        textDisplayController.text.substring(0,cursorCharIndex).split('\n').length;
    //Estimated vertical pixel positions of text cursor in TextField.
    double bottomCursorOffset = _calcCursorOffset(numNewlinesBeforeCursor);
    double topCursorOffset = bottomCursorOffset - cLineHeight;
    //Scroll offsets for top and bottom of screen
    double topScrollOffset = textDisplayScrollController.offset;
    double bottomScrollOffset = topScrollOffset + kTextDisplayHeight;

    // print('cursorcharindex: $cursorCharIndex');
    // print('calc:  $numNewlinesBeforeCursor ||   Offsets: $topScrollOffset, $topCursorOffset, $bottomCursorOffset, $bottomScrollOffset');

    //If cursor is not on screen, scroll so it is shown.
    if (  !(topScrollOffset < topCursorOffset) ||
        !(bottomCursorOffset < bottomScrollOffset)){
      double topDiff = topCursorOffset - topScrollOffset;
      double bottomDiff = bottomCursorOffset - bottomScrollOffset;
      int numLinesAdded =  (topDiff<0) ?
          -(topDiff ~/ cLineHeight + 1) :  bottomDiff ~/ cLineHeight +1 ;
      //Offset where top of display will scroll to.
      double newScrollOffset = topScrollOffset + cLineHeight*numLinesAdded;
      // print('>>numLines added:   $numLinesAdded, newoffset: $newScrollOffset');

      //Scroll to newScrollOffset
      textDisplayScrollController.animateTo(
          newScrollOffset,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut
      );
    }
  }


  void printPathListString(){
    print(formatPathListToStr( strokeListToPathList(_strokeList)));
  }

}