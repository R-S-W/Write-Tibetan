import 'dart:core';


class Letter {
  /*im only using a string to make letters.
  The strokes of the letter are all in 1 string, the pathString
   (from pathList, we got pathString.) 
   */
  String tibetanLetter;
  List<String>  strokeVariations;  //list of pathStrings
  List<int> numStrokesList = [];
  int numVariations ;

  Letter(String dataLine){
    List<String> dataList = dataLine.split(",");
    this.tibetanLetter = dataList[0];
    this.strokeVariations = dataList.sublist(1,dataList.length);
    this.strokeVariations.forEach((str) => 
        this.numStrokesList.add(str.split(" ").length) );
    this.numVariations = this.numStrokesList.length;
  }
}


class LetterPath {
  String pathString;
  int numStrokes;
  String tibetanLetter;

  LetterPath(String dataString){  // dataString = tibletter, pathstring.
    List<String> list1 = dataString.split(",");
    this.tibetanLetter = list1[0];
    this.pathString = list1[1];
    this.numStrokes = this.pathString.split(" ").length;
  }
}