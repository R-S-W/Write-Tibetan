// TibetanLetterFinder


import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math';
import 'LetterClasses.dart';
import 'LetterEncyclopedia.dart';




void TibetanLetterFinder(List<List<Offset>> inputStrokeList, List<String> Suggestions, LetterEncyclopedia Encyclopedia ){
  /*
    Classifications (Classifiers)
    number of strokes,    +- 1
    whether it is combined
    1st stroke type
    length of nth stroke

    longest stroke?

    if there's a really good match, then another stroke, consider a ratag or wasul

    Try to do a quick find, if the similarity below a certain tolerance, then quit it

    You have to consider that it may not be a complete letter, so you have to rank the initial Classifiers in a certain way depending on how many strokes there are.  If there are 2, do 1 ordering of classifiers.  If there's a lot of strokes, do another ordering.

   */

  //first we only check same exact number of strokes.
  Map<String,double> SuggestionMap; //used to create ordered list of suggestions


  //Check if the final stroke was a vowel
  if (inputStrokeList.length>=3){//(a letter w/ vowels needs at least 3 strokes)
    List<Offset> inputRectangleData =  smallestBoundingRectangle(inputStrokeList);
    List<Offset> prevInputRectangleData = smallestBoundingRectangle(inputStrokeList.sublist(0,inputStrokeList.length-1));



    // take the last stroke and see if it matches the vowels to a certain tolerance.
    double vowelDiffRatingTolerance = .75;
    Map<String,double> lastStrokeSuggestionMap = makeSuggestionMap([inputStrokeList.last], Encyclopedia);

    // If it's a vowel, 2 Possible cases:
    /*After the addition of the last stroke,
      1. The rectangle lengthened at the top AND the vowels kigu, drengbo, and naro were suggested
      2. The rectangle lengtheded at the bottom and the vowel shabkyu was suggested.
      */
    // (note that the coordinate frame is +x to the right and +y down)
    bool isTopVowel= inputRectangleData[0].dy < prevInputRectangleData[0].dy  &&  !(lastStrokeSuggestionMap.keys.first == "\u0f74" ) ; //\uof74 is shabkyu
    bool isBottomVowel = inputRectangleData[1].dy > prevInputRectangleData[1].dy && lastStrokeSuggestionMap.keys.first == "\u0f74" ;



    // print("vowelchecking------");
    // lastStrokeSuggestionMap.forEach((k, v)=> print("$k: $v"));
    // print("-----------------");

    // print ("$isTopVowel   $isBottomVowel   and  inputrectDim and output rectdim:   $inputRectangleData     $prevInputRectangleData");


    // if diffRating of best suggestion is below tolerance and it is either a top vowel xor bottom vowel
    if (lastStrokeSuggestionMap.values.first <= vowelDiffRatingTolerance && (isTopVowel || isBottomVowel)){
      String vowelToAdd = lastStrokeSuggestionMap.keys.first;

      // print("Is a vowel.  ->vowelToADD:  $vowelToAdd");

      //Since the previous letter suggestions are still in the list Suggestions, just update them.
      for (int i = 0; i< Suggestions.length; i++){
        Suggestions[i] += vowelToAdd;
      }
      return;

    }else { // not a vowel, compute the inputStroke in full.
      SuggestionMap = makeSuggestionMap(inputStrokeList,Encyclopedia, inputRectangleData);
    }
  }else{// 2-stroke letter
    SuggestionMap = makeSuggestionMap(inputStrokeList,Encyclopedia);
  }

  // print ("______________________________________________________");
  // print("the INPATHSTR:::$inPathStr");

  //////////printer///// SuggestionMap.forEach((key, value) {print("$key - $value            ${Encyclopedia.LetterDictionary[key].strokeVariations.first} ");});//print statement

  Suggestions.clear();
  SuggestionMap.keys.forEach((lStr) => Suggestions.add(lStr) );


  // print ("______________________________________________________");
}



Map<String, double>  makeSuggestionMap( List<List<Offset>> aStrokeList,  LetterEncyclopedia Encyclopedia, [List<Offset> rectData]){
  // helper function used in TibetanLetterFinder
  // Take a strokeList, turn it into a path string, and compare it with letters of the same length from the encyclopedia.
  // Compare it with differenceRating to give it a score.
  // return  a sorted list of suggestions, lowest differenceRating scores being the best suggestion.

  List<List<String>> inPathList = strokeListToPathList(aStrokeList, rectData);
  String inPathStr = formatPathListToStr(inPathList);
  LetterPath inputPath = LetterPath(",$inPathStr");
  Map<String, double> SuggestionMap  = Map<String, double>();
  // print("INPUTPATH pathstring:::${inputPath.pathString}:::");
  // print("INputpathnumstrokes:::${inputPath.numStrokes}");

  var sameLenLetterPaths =
  Encyclopedia.LetterPathsByStrokeCount[inputPath.numStrokes];
  for (int i=0; i<  sameLenLetterPaths.length; i++){
    LetterPath iLetterPath = sameLenLetterPaths[i];
    String iLetterKey = iLetterPath.TibetanLetter;

    // print("Current checked Letter:  ::::$iLetterKey::::");

    double dRating= differenceRating(inputPath, iLetterPath );

    bool isOldKey = SuggestionMap.containsKey(iLetterKey);
    bool isDRatingBetter = isOldKey && SuggestionMap[iLetterKey] > dRating;
    if (isDRatingBetter || ! isOldKey){
      SuggestionMap[iLetterKey] = dRating;
    }
  }

  //sort suggestionMap by its values.
  var sortedEntries = SuggestionMap.entries.toList()..sort((e1, e2) {
    var diff = e2.value.compareTo(e1.value);
    if (diff == 0) diff = e2.key.compareTo(e1.key);
    return diff;
  }); // sortedEntries in reverseorder.
  SuggestionMap..clear()..addEntries(sortedEntries.reversed);

  return SuggestionMap;
}





//------------------------------------------------------------------------------
List<List<String>> strokeListToPathList(List<List<Offset>> StrokeList, [List<Offset> rectangleData]){
  /*Converts the strokelist of position coordinates for the curves and
  transforms them into a list of string lists.  Each string list represents a
  stroke, each string element in the string list is a gridnumber.
 */
  if (StrokeList.length == 0){
    return null;
  }
  List<Offset> rectangleExtremaAndDimensions;
  //Find the largest rectangle by finding the points that have the xmin,xmax, ymin, and ymax of the entire strokelist
  if (rectangleData != null && rectangleData.length ==3) {
    rectangleExtremaAndDimensions = rectangleData;
  }else {
    rectangleExtremaAndDimensions = smallestBoundingRectangle(StrokeList);
  }
  //points for the constraining rectangle:
  // var minPoint = rectangleExtremaAndDimensions[0];
  // var maxPoint = rectangleExtremaAndDimensions[1];
  double xMin = rectangleExtremaAndDimensions[0].dx;
  double xMax = rectangleExtremaAndDimensions[1].dx;
  double yMin = rectangleExtremaAndDimensions[0].dy;
  double yMax = rectangleExtremaAndDimensions[1].dy;
  var rectDim =  rectangleExtremaAndDimensions[2];



    /*Take each point, discretize into the 3x3 rectangular grid in the
  constraining rectangle to create unabridgedPathList, the pathlist with
  duplicate consecutive numbers. */
  List<List<String>> unabridgedPathList = []; //The pathlist with all the duplicate numbers.
  for (int i= 0; i< StrokeList.length; i++){
    unabridgedPathList.add([]);
    for (int j=0; j< StrokeList[i].length; j++){
      int X = -1;
      int Y  = -1;

      //This deals with the points near the boundary, bypassing the possible floating point error and rounding down that might give the point the wrong discrete coordinates.
      if ( (StrokeList[i][j].dx-xMin).abs() < rectDim.dx/100 ){
        X = 0;
      } else if ( (xMax-StrokeList[i][j].dx).abs() < rectDim.dx/100 ){
        X = 2;
      }
      if ((StrokeList[i][j].dy-yMin).abs() < rectDim.dy/100 ){
        Y = 0;
      } else if ( (yMax-StrokeList[i][j].dy).abs() < rectDim.dy/100 ){
        Y = 2;
      }
      if (X==-1){
        X = (( (StrokeList[i][j].dx - xMin)/rectDim.dx *3 ).floor() ).toInt() ;
      }
      if (Y == -1){
        Y = (( (StrokeList[i][j].dy - yMin)/rectDim.dy *3 ).floor() ).toInt() ;
      }

      int aGridNum = discreteCoordinatesToGridNumber([X,Y]);
      unabridgedPathList[i].add(aGridNum.toString());
    }
  }

  // print("Unabridged pathlist: ${unabridgedPathList}");

  // Remove "duplicate" points that are in the same gridspace as the previous point.
  // From this, see if a duplicate point cluster is long enough.  If it only is in a gridspace for 4  points, then add an apostrophe to say that it is a weak/possible entry.
  List<List<String>> pathList = [];
  for (int  i=0; i< unabridgedPathList.length; i++){
    int duplicateCounter = 1;
    String currentPathNum = unabridgedPathList[i][0];
    pathList.add([]);
    for (int j=1; j< unabridgedPathList[i].length; j++){
      if (currentPathNum == unabridgedPathList[i][j]){
        duplicateCounter+=1;
      }else{
        duplicateCounter > 2 ? pathList[i].add(currentPathNum)
            :  pathList[i].add(numberToAlphabet(currentPathNum));
        currentPathNum = unabridgedPathList[i][j];
        duplicateCounter=1;
      }
    }
    //for the final duplicate pathnumber cluster.
    duplicateCounter > 2 ? pathList[i].add(currentPathNum)
        :  pathList[i].add(numberToAlphabet(currentPathNum));
  }
  return pathList;

}



//----------------------------------
List<Offset> smallestBoundingRectangle(List<List<Offset>> StrokeList){
  // Finds the smallest possible circumscribed rectangle for the given plane curve.
  // returns [ (xmin,ymin)  ,  (xmax, ymax)  ,  (width, length) ]
  double xMin = StrokeList[0][0].dx;
  double xMax = StrokeList[0][0].dx;
  double yMin = StrokeList[0][0].dy;
  double yMax = StrokeList[0][0].dy;

  for (int i=0; i < StrokeList.length; i++){
    for (int j=0; j< StrokeList[i].length; j++){
      xMin > StrokeList[i][j].dx ? xMin = StrokeList[i][j].dx : null;
      yMin > StrokeList[i][j].dy ? yMin = StrokeList[i][j].dy : null;
      xMax < StrokeList[i][j].dx ? xMax = StrokeList[i][j].dx : null;
      yMax < StrokeList[i][j].dy ? yMax = StrokeList[i][j].dy : null;
    }
  }
  return [ Offset(xMin,yMin), Offset(xMax,yMax), Offset(xMax-xMin, yMax-yMin) ];
}


//----------------------------------
String formatPathListToStr(List<List<String>> pathList){
  String pathString = "";
  for (int i=0; i< pathList.length; i++){
    for (int j=0; j< pathList[i].length; j++){
      pathString+= pathList[i][j];
    }
    pathString+=" ";
  }
  return pathString.substring(0,pathString.length - 1);
}




//------------------------------------------------------------------------------
double differenceRating(LetterPath aa, LetterPath bb){
  /* for each pair of corresponding strokes,
     run segmentPathNumber on the pair to break up each stroke pathnumber into
     a pathnumber cluster.  from the pair of clusters, take each corresponding
     pathnumber segment and compute the metric of the two numbers.  Add all of
     the segment metrics together to get the strokeDifferenceRating.  add all
     Si together from all strokes and divide by the total number of segment
     pairs in all of the  strokes.  = differenceRating.
*/
  String a = aa.pathString;
  String b = bb.pathString;
  List<String> aList = a.split(" ");
  List<String> bList = b.split(" ");
  assert (aList.length ==bList.length);

  //break up into a pair of pathnumber clusters
  int NumTotalSegmentPairs= 0;
  double DiffRating = 0;

  for (int i = 0; i< aList.length; i++){   //for each stroke,
    // split the pair into segments with minimal matching letters.
    List<String> spacedPairOfSegments = segmentPathNumber([aList[i],bList[i]]);
    List<String> segmentedA = spacedPairOfSegments[0].split(" ");
    List<String> segmentedB = spacedPairOfSegments[1].split(" ");

    if (segmentedA.length != 0 ) { // if it's not a perfect match

      for (int j = 0; j < segmentedA.length; j++) { // for each segment pair,
        double segmentDiffRating = 0;

        if (segmentedA[j].length == segmentedB[j].length) {
          // print("sega and segb equal length");
          //sum the metrics of the corresponding pairs of letters.
          for (int k = 0; k < segmentedA[j].length; k++) {
            segmentDiffRating += gridMetric(segmentedA[j][k], segmentedB[j][k]);
          }
        } else{//sum metric of  all pairings of letters between the strings
          // print("sega and segb not equal length");
          for (int l = 0; l < segmentedA[j].length; l++) { //for each letter in segmentedA,
            for (int m = 0; m < segmentedB[j].length; m++) {
              segmentDiffRating +=
                  gridMetric(segmentedA[j][l], segmentedB[j][m]);
            }
          }// then divide by sqrt(a.length*b.length)
          segmentDiffRating /= sqrt(segmentedA[j].length * segmentedB[j].length);

        }
        DiffRating += segmentDiffRating;
      }
      NumTotalSegmentPairs += segmentedA.length;

    }

  }
  DiffRating /= NumTotalSegmentPairs;
  return DiffRating;
}







//------------------------------------------------------------------------------
/*PROBLEMS
didnt weight by type yet

also i think the characters for 1 and a wont equal, nor 2 and b and etc.
 */

List<String> segmentPathNumber(List<String> pathPair){
  // returns a pair of strings with the original path split apart by spaces.
  /*
Recursive function used in differenceRating.  Takes a pair of pathList strings
and returns a pair of spaced strings.  Each element of a spaced string is a
segment of the original.

The function takes the two strings A and B and
1. offsets the second one such that there is a maximum amount of shared
characters that match both strings,
2. removes the matching letters and starts splitting the strings into
segments at those points by add.
2.5* If the pair of corresponding segments at the beginning or end of the
string have different lengths, then we don't remove the matching letter from
the split.
3. For each pair of corresponding segments of the string, we run this function
again.  It stops until the input pair of strings has no matching elements.
*/
  // print("PATH PAIR ::|${pathPair[0]}|${pathPair[1]}|");
  String A = pathPair[0];
  String B = pathPair[1];

  //find the BOffset (=i) with the most matches.
  int BOffset  = 0;
  List<int> optimalSameIndices=[];
  List<int> tempIndices = [];
  int tempNumMatches= 0;
  for (int i = -B.length+1 ; i< A.length-1; i++){   //1.   changed A and b on 11-26
    tempIndices = sameCharIndices(A,B,i);
    if ( tempIndices.length > tempNumMatches ){
      tempNumMatches = tempIndices.length;
      optimalSameIndices = tempIndices;
      BOffset = i;
    }
  }
  // print("OptIndices::$optimalSameIndices  |||Offset: $BOffset");

  //check if the pair cannot be segmented anymore.  3 Cases:
  bool isNoMatches = optimalSameIndices.length == 0;  //no matching characters
  //if the pair has 1 matching letter, is from the edges of its parent string, and has 1 string with length 1,
  bool isIrreducibleEdge = optimalSameIndices.length==1 && (A.length ==1  || B.length==1 );
  if (isNoMatches || isIrreducibleEdge ) {
    // print("reduced.");
    return pathPair;
  }
  if (optimalSameIndices.length == A.length && A.length == B.length){//complete match
    return ["",""];
  }






  List<List<String>> segmentedPairOfPaths = [[],[]];
  List<String> tempAList = [];
  List<String> tempBList = [];

  //add all path segments where the paths are PAIRED, or overlap.  These segments exclude all matching letters.
  for (int j = 0; j< optimalSameIndices.length - 1; j++) {
    tempAList.add(
        A.substring(optimalSameIndices[j] + 1, optimalSameIndices[j + 1]));//don't add the matching values (nodes) to the segments if its in the bulk of the path
    tempBList.add(B.substring(optimalSameIndices[j] + 1 - BOffset,
        optimalSameIndices[j + 1] - BOffset));
  }
  // print("proto temps:${tempAList}||$tempBList");


  //now add the paths at the beginning and end of the pair strings. These might include some matched letters.

  if (A.substring(0,optimalSameIndices.first).length !=0  && B.substring(0,optimalSameIndices.first-BOffset).length !=0 ){
    //if both strings have elements before the first match, add them w/o the 1st matched letter.
    tempAList.insert(0,A.substring(0,optimalSameIndices[0]));
    tempBList.insert(0,B.substring(0,optimalSameIndices[0]-BOffset));

  }else if (BOffset > 0){// if A has unpaired characters at beginning of string
    if (optimalSameIndices[0] == BOffset){//If the first matching letter is the first element of B,
      //put the matching letter B[0] in the first path segment pair.
      tempAList.insert(0, A.substring(0, BOffset + 1));
      tempBList.insert(0, B[0]);
    }

  }else if (BOffset < 0){// if B has unpaired characters
    if (optimalSameIndices[0] == 0){// if the first matching letter is A[0]
      //include A[0] in the first path segment pair.
      tempAList.insert(0, A[0]);
      tempBList.insert(0,B.substring(0, -BOffset + 1) );
    }
  }

  //if both strings have elements after the last match, add them w/o the last matched letter
  if (A.substring(optimalSameIndices.last+1, A.length).length != 0  &&
  B.substring(optimalSameIndices.last - BOffset + 1, B.length).length != 0 ){
    tempAList.add(A.substring(optimalSameIndices.last+1,A.length));
    tempBList.add(B.substring(optimalSameIndices.last - BOffset + 1, B.length));

  }else if (A.length != B.length + BOffset){  // If there are unpaired letters at the end of one of the letterpaths
    if (A.length < B.length+BOffset) { //If B has unpaired letters
      if (optimalSameIndices.last == A.length - 1) { // If the last matching letter was A[-1]
        //add that letter to the last path segment pair
        tempAList.add(A[A.length - 1]);
        tempBList.add(B.substring(A.length - 1 - BOffset, B.length)); /////
      }

    }else if (A.length > B.length+BOffset){// if A has unpaired letters
      if (optimalSameIndices.last == B.length -1 + BOffset){
        tempAList.add(A.substring(optimalSameIndices.last, A.length));
        tempBList.add(B[B.length-1]);
      }
    }

  }
  //remove empty elements from tempAList and tempBList, where there were consecutive matching letters that were cut out.
  while (tempAList.remove("")){
    tempBList.remove("");
  }

  // print("$tempAList $tempBList,  of  $A  and  $B");
  // print("TEMPLISTS: $tempAList | $tempBList");

  if (tempAList.length == 0 ){//the pair matched completely
    // print("complete match");
    return ["",""];
  }
  segmentedPairOfPaths[0] = tempAList;
  segmentedPairOfPaths[1] = tempBList;





  List<String> newPathPair = ["",""];
  //continue to use segmentedPathNumber until there are no more strings to match and split.
  for (int k = 0; k< segmentedPairOfPaths[0].length; k++){
    // print("Recursion-----------------------------");
    List<String>  tempSegPathNum = segmentPathNumber( [ segmentedPairOfPaths[0][k], segmentedPairOfPaths[1][k] ] ); /////// right?
    newPathPair[0] += " "+tempSegPathNum[0];
    newPathPair[1] += " "+tempSegPathNum[1];
  }

  // print("Newer one::|${newPathPair[0]}|${newPathPair[1]}|");
  return newPathPair;
}



//---------------------------------
List<int> sameCharIndices(String A, String B, int BOffset){
  /*Find the indices with matching characters for A and B, with B shifted
  BOffset indices to the right.  Used in segmentPathNumber
  */
  // the indices and offset are with respect to the first string, A.
  int startIndex = max(0,BOffset);
  int endIndex = min(A.length-1, B.length-1+BOffset);
  List<int> sameCharList=[];

  for (int i = startIndex; i<=endIndex; i++){
    if (A[i] == B[i-BOffset]){
      sameCharList.add(i);
    }
  }
  return sameCharList;
}


//-----------------------------------
double gridMetric(String C, String D){
  //Used in differenceRating.  Determines the difference between 2 gridnumbers
  List<int> CC = gridNumberToDiscreteCoordinates(C);
  List<int> DD = gridNumberToDiscreteCoordinates(D);
  bool isCNumber = isNumber(C);
  bool isDNumber = isNumber(D);
  double value =  sqrt( pow(CC[0]-DD[0],2) + pow(CC[1]-DD[1],2));

  // print("___C and D::$C   $D ------CC and DD::$CC  $DD-----  pre Value::$value");
  // print("bools:  $isCNumber  $isDNumber");

  if (isCNumber && isDNumber ){// if both are number gridletters
    return value;
  }else if ( !isCNumber && !isDNumber ){// if alphabet gridnumber
    return value*2;
  }else {// if one gridnumber is a number and one is an alphabet letter,
    if (value.abs() <pow(10,-15) ){//if C, D are different gridnumbers, but on same gridspace
      //We make sure the metric is nonzero for different gridnumbers.
      return .5;
    } else {// different gridnumbers, different gridspaces
      return value*3;
    }
  }
}




//------------------------------------
int  discreteCoordinatesToGridNumber(List<int> R){
  //Helper function to strokeListToPathList
  int aNumber = 10*R[0]+R[1];
  // I did this because there was an error using offset with a switch statement
  //ordered by assumed gridnumber frequency.
  switch(aNumber){
    case 11: return 5;
    break;
    case 1: return 4;
    break;
    case 21: return 6;
    break;
    case 0: return 1;
    break;
    case 10: return 2;
    break;
    case 12: return 8;
    break;
    case 20: return 3;
    break;
    case 22: return 9;
    break;
    case 2: return 7;
  }
  return null;
}



List<int>  gridNumberToDiscreteCoordinates(String gridNum ){
  //inverse of discreteCoordinatesToGridNumber.
  switch (gridNum){
    case "5": return [1,1];
    break;
    case "e": return [1,1];
    break;
    case "4":return [0,1];
    break;
    case "d":return [0,1];
    break;
    case "6": return [2,1];
    break;
    case "f": return [2,1];
    break;
    case "1": return [0,0];
    break;
    case "a": return [0,0];
    break;
    case "2": return [1,0];
    break;
    case "b": return [1,0];
    break;
    case "8": return [1,2];
    break;
    case "h": return [1,2];
    break;
    case "3": return [2,0];
    break;
    case "c": return [2,0];
    break;
    case "9": return [2,2];
    break;
    case "i": return [2,2];
    break;
    case "7": return [0,2];
    break;
    case "g": return [0,2];
  }
  return null;
}




String numberToAlphabet(String c){
  switch (c){
    case "1": return "a";
    case "2": return "b";
    case "3": return "c";
    case "4": return "d";
    case "5": return "e";
    case "6": return "f";
    case "7": return "g";
    case "8": return "h";
    case "9": return "i";
  }
  return null;
}

String alphabetToNumber(String d){
  switch (d){
    case "a": return "1";
    case "b": return "2";
    case "c": return "3";
    case "d": return "4";
    case "e": return "5";
    case "f": return "6";
    case "g": return "7";
    case "h": return "8";
    case "i": return "9";
  }
  return null;
}

bool isNumber(String b){
  //used in gridMetric
  return "123456789".contains(b);
}