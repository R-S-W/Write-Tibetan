// TibetanLetterFinder


import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:math';
import '../letter_files/letter_classes.dart';
import '../letter_files/letter_encyclopedia.dart';







void tibetanLetterFinder(List<List<Offset>> inputStrokeList,
    List<String> suggestions,
    LetterEncyclopedia encyclopedia ){
  /*
    Classifications (Classifiers)
    number of strokes,    +- 1
    whether it is combined
    1st stroke type
    length of nth stroke

    longest stroke?

    if there's a really good match, then another stroke, consider a ratag or wasul

    Try to do a quick find, if the similarity below a certain tolerance, then
    quit it

    You have to consider that it may not be a complete letter, so you have to
    rank the initial Classifiers in a certain way depending on how many strokes
    there are.  If there are 2, do 1 ordering of classifiers.  If there's a lot
    of strokes, do another ordering.

   */

  //first we only check same exact number of strokes.
  Map<String,double> suggestionMap; //used to create ordered list of suggestions
  int inputLength = inputStrokeList.length;

  //Check for Vowels.
  //all 4 vowels are 1 stroke, but naro also has a 2-stroke variation.
  //(1) check if the final stroke was a 1-stroke vowel.
  //(2) if not, check if it was a 2-stroke naro vowel.
  double oneStrokeVowelDiffRatingTolerance = .75;
  double twoStrokeNaroDiffRatingTolerance = 1;
  //inputRectangleData: constraining rectangle of all the strokes
  List<Offset> inputRectangleData = smallestBoundingRectangle(
      inputStrokeList);



  if(inputLength >2){ //Check if it may have a vowel.
    //all 4 vowels are 1 stroke, but naro also has a 2-stroke variation.
    //(1) check if the final stroke was a 1-stroke vowel.
    //(2) if not, check if it was a 2-stroke naro vowel.

    int vowelLen = 1; // vowel Stroke Length, used as iterator.

    // Check for vowels of stroke Length 1 (vowelLen=1) and
    // check for naro of stroke length 2 (vowelLen=2)
    for (; vowelLen <= 2; vowelLen++) {
      //prevInputRectangleData: constraining rectangle of all strokes except
      // the last stroke.
      //We will compare them to see if the inputRectangle grew above or below.
      List<Offset> prevInputRectangleData =
      smallestBoundingRectangle(
          inputStrokeList.sublist(0, inputLength - vowelLen));

      //Take the last vowelLen strokes and see if they match the vowels to
      // a certain tolerance: vowelDiffRatingtolerance.
      Map<String, double> finalStrokesSuggestionMap =
      makeSuggestionMap(
          inputStrokeList.sublist(inputLength - vowelLen, inputLength),
          encyclopedia,
      );


      bool isTopVowel;
      bool isBottomVowel;
      bool isVowel;

      //If we're checking 1-stroke vowels,
      if (vowelLen == 1) {
        //2 Possible cases:
        /*After the addition of the last stroke,
        1. The rectangle lengthened at the top AND the vowels kigu, drengbo,
          and naro were suggested
        2. The rectangle lengthened at the bottom and the vowel shabkyu was
          suggested.
        */
        // (note that the coordinate frame is +x to the right and +y down)
        isTopVowel = inputRectangleData[0].dy < prevInputRectangleData[0].dy &&
            !(finalStrokesSuggestionMap.keys.first ==
                "\u0f74"); //u0f74 =shabkyu

        isBottomVowel = inputRectangleData[1].dy > prevInputRectangleData[1].dy
            && finalStrokesSuggestionMap.keys.first == "\u0f74";

        // check if diffRating of best suggestion is below tolerance AND
        //  if it is either a  top vowel xor bottom vowel,
        isVowel = (finalStrokesSuggestionMap.values.first <=
            oneStrokeVowelDiffRatingTolerance) && (isTopVowel || isBottomVowel);

        //if we're checking the 2-stroke naro,
      }else if (vowelLen == 2) {
        //Check if the constraining rectangle lengthened after the addition of
        // the last 2 strokes  and if the first suggested letter was naro.
        isTopVowel = inputRectangleData[0].dy < prevInputRectangleData[0].dy
            && finalStrokesSuggestionMap.keys.first == "\u0f7c"; // u0f7c = naro
        //Check if isTopVowel AND suggestion diff rating is below tolerance
        isVowel = isTopVowel && (finalStrokesSuggestionMap.values.first <=
            twoStrokeNaroDiffRatingTolerance);
      }


      if (isVowel) {
        //gigu,drengbo,shapkyu,naro
        String vowelString = "\u0f72\u0f7a\u0f74\u0f7c";

        String vowelToAdd = finalStrokesSuggestionMap.keys.first;
        //If the previous letter suggestions did not have any letters with
        // vowels,
        if(vowelString.indexOf(suggestions.first[suggestions.first.length-1])<0)
        {//update the suggestions list.
          //Do some Spelling Checks
          bool isSpellingOkay;
          for (int i=0; i< suggestions.length; i++){
            isSpellingOkay = true;
            //1.  The letter wa is also a suffix.  If the suffix
            // form of wa, watag, is used in a letter, the tibetan keyboard
            // does not allow an addition of the shabkyu vowel, \u0f74.

            // bool a = vowelToAdd == vowelString[2] ;
            // bool b = sug[sug.length-1] == "\u0fad" ;
            // bool c = sug.length >1;
            // print ([a,b,c]);

            if ( vowelToAdd == vowelString[2] &&
                suggestions[i][suggestions[i].length-1] == "\u0fad" &&
                suggestions[i].length >1){
              isSpellingOkay = false;
            }
            if (isSpellingOkay){
              suggestions[i]+=vowelToAdd;
            }
          }

          //
          // for (int i = 0; i < suggestions.length; i++) {
          //   suggestions[i] += vowelToAdd;
          // }
        }else{//if  prev suggestions have vowels,  remove them.
          suggestionMap = makeSuggestionMap(
              inputStrokeList.sublist(0,inputLength - vowelLen),
              encyclopedia,
              prevInputRectangleData
          );
          suggestions.clear();
          suggestionMap.keys.forEach((lStr) =>suggestions.add(lStr+vowelToAdd));
        }
        return;
      }
    }
    //At this point, the suggestions don't have a vowel.
    // Make suggestions without vowels.
    suggestionMap = makeSuggestionMap(
        inputStrokeList, encyclopedia, inputRectangleData);
    suggestions.clear();
    suggestionMap.keys.forEach((lStr) => suggestions.add(lStr));



  }else { //it's a 2-stroke letter.
    // At this point, it's not a vowel. compute the inputStroke in full.
    suggestionMap = makeSuggestionMap(
        inputStrokeList, encyclopedia, inputRectangleData);
    suggestions.clear();
    suggestionMap.keys.forEach((lStr){
      if (lStr != "\u0f7c"){// if the 2-stroke character is not = naro
        suggestions.add(lStr);
      }
    });
  }


  // print ("______________________________________________________");
  // print("the INPATHSTR:::$inPathStr");
  //////////printer///// SuggestionMap.forEach((key, value) {print("$key - $value            ${Encyclopedia.LetterDictionary[key].strokeVariations.first} ");});//print statement


  // print ("______________________________________________________");
}




//misc for above
//(1) Check if the final stroke was a 1-strokevowel (=1s vowel)
//
// //inputRectangleData: constraining rectangle of all the strokes
// //prevInputRectangleData: constraining rectangle of all strokes except
// // the last stroke.
// //We will compare the two to see if the rectangle grew above or below.
// List<Offset> inputRectangleData = smallestBoundingRectangle(
//     inputStrokeList);
// List<Offset> prevInputRectangleData =
// smallestBoundingRectangle(
//     inputStrokeList.sublist(0, inputLength - 1));
//
// //take last stroke and see if it matches the vowels to a certain tolerance.
// Map<String, double> lastStrokeSuggestionMap =
// makeSuggestionMap([inputStrokeList.last], encyclopedia);
//
// // If it's a vowel, 2 Possible cases:
// /*After the addition of the last stroke,
//   1. The rectangle lengthened at the top AND the vowels kigu, drengbo, and
//    naro were suggested
//   2. The rectangle lengthened at the bottom and the vowel shabkyu was
//   suggested.
//   */
// // (note that the coordinate frame is +x to the right and +y down)
// bool isTopVowel = inputRectangleData[0].dy <
//     prevInputRectangleData[0].dy &&
//     !(lastStrokeSuggestionMap.keys.first == "\u0f74"); //\uof74 is shabkyu
// bool isBottomVowel = inputRectangleData[1].dy >
//     prevInputRectangleData[1].dy
//     && lastStrokeSuggestionMap.keys.first == "\u0f74";
//
//
// // print("vowelchecking------");
// // lastStrokeSuggestionMap.forEach((k, v)=> print("$k: $v"));
// // print("-----------------");
// // print ("$isTopVowel   $isBottomVowel   and  inputrectDim and output rectdim:   $inputRectangleData     $prevInputRectangleData");
//
//
//
// // IF diffRating of best suggestion is below tolerance and it is either a
// // top vowel xor bottom vowel,
// if (lastStrokeSuggestionMap.values.first <= vowelDiffRatingTolerance &&
//     (isTopVowel || isBottomVowel)) {
//   String vowelToAdd = lastStrokeSuggestionMap.keys.first;
//
//   // print("Is a vowel.  ->vowelToADD:  $vowelToAdd");
//
//   //Since the previous letter suggestions are still in the list Suggestions,
//   // just update them.
//   for (int i = 0; i < suggestions.length; i++) {
//     suggestions[i] += vowelToAdd;
//   }
//   return;
//
//
//   //(2) Check if it is a 2-stroke Naro vowel
// }else if (inputLength >=4){
//
//   //change prevInputRectangleData to find constraining rectangle of all but
//   //the last two strokes, then compare with inputRectangleData.
//   prevInputRectangleData=
//       smallestBoundingRectangle(
//           inputStrokeList.sublist(0, inputLength - 2));
//   lastStrokeSuggestionMap = makeSuggestionMap(
//         inputStrokeList.sublist(inputLength-2,inputLength), encyclopedia);
//
//   isTopVowel = inputRectangleData[0].dy < prevInputRectangleData[0].dy &&
//     lastStrokeSuggestionMap.keys.first =="\u0f7c";
//
//
//   //if it is a top vowel and naro suggestion rating is below tolerance:
//   if (isTopVowel &&
//       lastStrokeSuggestionMap.values.first <= vowelDiffRatingTolerance ){
//
//   }















Map<String, double>  makeSuggestionMap(
    List<List<Offset>> aStrokeList,
    LetterEncyclopedia encyclopedia,
    [List<Offset> rectData,]){
  /* helper function used in TibetanLetterFinder
     1. Take a strokeList, turn it into a path string, and compare it with
     letters of the same length from the encyclopedia.
     2. Compare it with differenceRating to give it a score.
     3. return  a sorted list of suggestions, lowest differenceRating scores
     being the best suggestion.


     - makeSuggestionMap is used multiple times in TibetanLetterFinder;
     the optional arg rectData that has the vertices of the constraining
     rectangle.  It is used to skip the calculation of the vertices that is done
     in the function below.

   */

  List<List<String>> inPathList = strokeListToPathList(aStrokeList, rectData);
  String inPathStr = formatPathListToStr(inPathList);
  LetterPath inputPath = LetterPath(",$inPathStr");
  Map<String, double> suggestionMap  = Map<String, double>();
  // print("INPUTPATH pathstring:::${inputPath.pathString}:::");
  // print("INputpathnumstrokes:::${inputPath.numStrokes}");

  var sameLenLetterPaths =
  encyclopedia.letterPathsByStrokeCount[inputPath.numStrokes];
  for (int i=0; i<  sameLenLetterPaths.length; i++){
    LetterPath iLetterPath = sameLenLetterPaths[i];
    String iLetterKey = iLetterPath.tibetanLetter;

    // print("Current checked Letter:  ::::$iLetterKey::::");

    double dRating= differenceRating(inputPath, iLetterPath );

    bool isOldKey = suggestionMap.containsKey(iLetterKey);
    bool isDRatingBetter = isOldKey && suggestionMap[iLetterKey] > dRating;
    if (isDRatingBetter || ! isOldKey){
      suggestionMap[iLetterKey] = dRating;
    }
  }

  //sort suggestionMap by its values.
  var sortedEntries = suggestionMap.entries.toList()..sort((e1, e2) {
    var diff = e2.value.compareTo(e1.value);
    if (diff == 0) diff = e2.key.compareTo(e1.key);
    return diff;
  }); // sortedEntries in reverseorder.
  suggestionMap..clear()..addEntries(sortedEntries.reversed);

  return suggestionMap;
}





//------------------------------------------------------------------------------
List<List<String>> strokeListToPathList(
    List<List<Offset>> strokeList,
    [List<Offset> rectangleData]){
  /*Converts the strokelist of position coordinates for the curves and
  transforms them into a list of string lists.  Each string list represents a
  stroke, each string element in the string list is a gridnumber.
 */
  if (strokeList.length == 0){
    return null;
  }
  List<Offset> rectangleExtremaAndDimensions;
  //Find the largest rectangle by finding the points that have the xmin,xmax,
  // ymin, and ymax of the entire strokelist
  if (rectangleData != null && rectangleData.length ==3) {
    rectangleExtremaAndDimensions = rectangleData;
  }else {
    rectangleExtremaAndDimensions = smallestBoundingRectangle(strokeList);
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

  // pathlist with all the duplicate numbers.
  List<List<String>> unabridgedPathList = [];
  for (int i= 0; i< strokeList.length; i++){
    unabridgedPathList.add([]);
    for (int j=0; j< strokeList[i].length; j++){
      int X = -1;
      int Y  = -1;

      //This deals with the points near the boundary, bypassing the possible
      // floating point error and rounding down that might give the point the
      // wrong discrete coordinates.
      if ( (strokeList[i][j].dx-xMin).abs() < rectDim.dx/100 ){
        X = 0;
      } else if ( (xMax-strokeList[i][j].dx).abs() < rectDim.dx/100 ){
        X = 2;
      }
      if ((strokeList[i][j].dy-yMin).abs() < rectDim.dy/100 ){
        Y = 0;
      } else if ( (yMax-strokeList[i][j].dy).abs() < rectDim.dy/100 ){
        Y = 2;
      }
      if (X==-1){
        X = (( (strokeList[i][j].dx - xMin)/rectDim.dx *3 ).floor() ).toInt() ;
      }
      if (Y == -1){
        Y = (( (strokeList[i][j].dy - yMin)/rectDim.dy *3 ).floor() ).toInt() ;
      }

      int aGridNum = discreteCoordinatesToGridNumber([X,Y]);
      unabridgedPathList[i].add(aGridNum.toString());
    }
  }

  // print("Unabridged pathlist: ${unabridgedPathList}");

  //Remove "duplicate" points that are in the same gridspace as  previous point.
  // From this, see if a duplicate point cluster is long enough.  If it only is
  // in a gridspace for 4  points, then add a letter instead to say that it is a
  // weak/possible entry.
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
List<Offset> smallestBoundingRectangle(List<List<Offset>> strokeList){
  //Finds smallest possible circumscribed rectangle for the given plane curve.
  // returns [ (xmin,ymin)  ,  (xmax, ymax)  ,  (width, length) ]
  double xMin = strokeList[0][0].dx;
  double xMax = strokeList[0][0].dx;
  double yMin = strokeList[0][0].dy;
  double yMax = strokeList[0][0].dy;

  for (int i=0; i < strokeList.length; i++){
    for (int j=0; j< strokeList[i].length; j++){
      if (xMin > strokeList[i][j].dx) xMin = strokeList[i][j].dx;
      if (yMin > strokeList[i][j].dy) yMin = strokeList[i][j].dy;
      if (xMax < strokeList[i][j].dx) xMax = strokeList[i][j].dx;
      if (yMax < strokeList[i][j].dy) yMax = strokeList[i][j].dy;
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
  int numTotalSegmentPairs= 0;
  double diffRating = 0;

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

          //for each letter in segmentedA,
          for (int l = 0; l < segmentedA[j].length; l++) {
            for (int m = 0; m < segmentedB[j].length; m++) {
              segmentDiffRating +=
                  gridMetric(segmentedA[j][l], segmentedB[j][m]);
            }
          }// then divide by sqrt(a.length*b.length)
          segmentDiffRating /= sqrt(segmentedA[j].length*segmentedB[j].length);

        }
        diffRating += segmentDiffRating;
      }
      numTotalSegmentPairs += segmentedA.length;

    }

  }
  diffRating /= numTotalSegmentPairs;
  return diffRating;
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
  int bOffset  = 0;
  List<int> optimalSameIndices=[];
  List<int> tempIndices = [];
  int tempNumMatches= 0;
  for (int i = -B.length+1 ; i< A.length-1; i++){
    tempIndices = sameCharIndices(A,B,i);
    if ( tempIndices.length > tempNumMatches ){
      tempNumMatches = tempIndices.length;
      optimalSameIndices = tempIndices;
      bOffset = i;
    }
  }
  // print("OptIndices::$optimalSameIndices  |||Offset: $BOffset");

  //check if the pair cannot be segmented anymore.  3 Cases:
  bool isNoMatches = optimalSameIndices.length == 0;  //no matching characters
  //if the pair has 1 matching letter, is from the edges of its parent string,
  // and has 1 string with length 1,
  bool isIrreducibleEdge =
      optimalSameIndices.length==1 && (A.length ==1 || B.length==1 );
  if (isNoMatches || isIrreducibleEdge ) {
    // print("reduced.");
    return pathPair;
  }
  //if complete match
  if (optimalSameIndices.length == A.length && A.length == B.length){
    return ["",""];
  }



  List<List<String>> segmentedPairOfPaths = [[],[]];
  List<String> tempAList = [];
  List<String> tempBList = [];

  //add all path segments where the paths are PAIRED, or overlap.
  // These segments exclude all matching letters.
  for (int j = 0; j< optimalSameIndices.length - 1; j++) {
    //don't add the matching values (nodes) to the segments if its in the
    // bulk of the path
    tempAList.add(
        A.substring(optimalSameIndices[j] + 1, optimalSameIndices[j + 1]));
    tempBList.add(B.substring(optimalSameIndices[j] + 1 - bOffset,
        optimalSameIndices[j + 1] - bOffset));
  }
  // print("proto temps:${tempAList}||$tempBList");


  //now add the paths at the beginning and end of the pair strings.
  // These might include some matched letters.

  if (A.substring(0,optimalSameIndices.first).length !=0  &&
      B.substring(0,optimalSameIndices.first-bOffset).length !=0 ){
    //if both strings have elements before the first match,
    // add them w/o the 1st matched letter.
    tempAList.insert(0,A.substring(0,optimalSameIndices[0]));
    tempBList.insert(0,B.substring(0,optimalSameIndices[0]-bOffset));

  }else if (bOffset > 0){// if A has unpaired characters at beginning of string
    //If the first matching letter is the first element of B,
    if (optimalSameIndices[0] == bOffset){
      //put the matching letter B[0] in the first path segment pair.
      tempAList.insert(0, A.substring(0, bOffset + 1));
      tempBList.insert(0, B[0]);
    }

  }else if (bOffset < 0){// if B has unpaired characters
    if (optimalSameIndices[0] == 0){// if the first matching letter is A[0]
      //include A[0] in the first path segment pair.
      tempAList.insert(0, A[0]);
      tempBList.insert(0,B.substring(0, -bOffset + 1) );
    }
  }

  //if both strings have elements after the last match,
  // add them w/o the last matched letter
  if (A.substring(optimalSameIndices.last+1, A.length).length != 0  &&
  B.substring(optimalSameIndices.last - bOffset + 1, B.length).length != 0 ){
    tempAList.add(A.substring(optimalSameIndices.last+1,A.length));
    tempBList.add(B.substring(optimalSameIndices.last - bOffset + 1, B.length));

    // If there are unpaired letters at the end of one of the letterpaths
  }else if (A.length != B.length + bOffset){
    //If B has unpaired letters
    if (A.length < B.length+bOffset) {
      // If the last matching letter was A[-1]
      if (optimalSameIndices.last == A.length - 1) {
        //add that letter to the last path segment pair
        tempAList.add(A[A.length - 1]);
        tempBList.add(B.substring(A.length - 1 - bOffset, B.length));
      }
      // if A has unpaired letters
    }else if (A.length > B.length+bOffset){
      if (optimalSameIndices.last == B.length -1 + bOffset){
        tempAList.add(A.substring(optimalSameIndices.last, A.length));
        tempBList.add(B[B.length-1]);
      }
    }

  }
  //remove empty elements from tempAList and tempBList, where there were
  // consecutive matching letters that were cut out.
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
  //continue using segmentedPathNumber until there are no more strings to match
  // and split.
  for (int k = 0; k< segmentedPairOfPaths[0].length; k++){
    // print("Recursion-----------------------------");
    List<String>  tempSegPathNum =
    segmentPathNumber([segmentedPairOfPaths[0][k],segmentedPairOfPaths[1][k] ]); /////// right?
    newPathPair[0] += " "+tempSegPathNum[0];
    newPathPair[1] += " "+tempSegPathNum[1];
  }

  // print("Newer one::|${newPathPair[0]}|${newPathPair[1]}|");
  return newPathPair;
}



//---------------------------------
List<int> sameCharIndices(String A, String B, int bOffset){
  /*Find the indices with matching characters for A and B, with B shifted
  BOffset indices to the right.  Used in segmentPathNumber
  */
  // the indices and offset are with respect to the first string, A.
  int startIndex = max(0,bOffset);
  int endIndex = min(A.length-1, B.length-1+bOffset);
  List<int> sameCharList=[];

  for (int i = startIndex; i<=endIndex; i++){
    if (A[i] == B[i-bOffset]){
      sameCharList.add(i);
    }
  }
  return sameCharList;
}


//-----------------------------------
double gridMetric(String C, String D){
  //Used in differenceRating.  Determines the difference between 2 gridnumbers
  List<int> cC = gridNumberToDiscreteCoordinates(C);
  List<int> dD = gridNumberToDiscreteCoordinates(D);
  bool isCNumber = isNumber(C);
  bool isDNumber = isNumber(D);
  double value =  sqrt( pow(cC[0]-dD[0],2) + pow(cC[1]-dD[1],2));

  // print("___C and D::$C   $D ------CC and DD::$CC  $DD-----  pre Value::$value");
  // print("bools:  $isCNumber  $isDNumber");

  if (isCNumber && isDNumber ){// if both are number gridletters
    return value;
  }else if ( !isCNumber && !isDNumber ){// if alphabet gridnumber
    return value*2;
  }else {// if one gridnumber is a number and one is an alphabet letter,
    //if C, D are different gridnumbers, but on same gridspace
    if (value.abs() <pow(10,-15) ){
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