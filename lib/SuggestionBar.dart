

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'MyChangeNotifierClasses.dart';
/////USE THE TIMER CLASS TO CHECK FOR UPDATES



class SuggestionBar extends StatefulWidget {
  // List<String> Letter;
  // List<List<String>> LetterList;
  List<String> Suggestions;
  final Function(String)  tappedLetterCallback; // no final on this voidcallback



  //SuggestionBar({@required this.Letter, @required this.LetterList,@required this.Sentence, @required this.tappedLetterCallback});
  SuggestionBar({@required this.Suggestions, @required this.tappedLetterCallback});

  @override
  _SuggestionBarState createState() => _SuggestionBarState();
}

class _SuggestionBarState extends State<SuggestionBar> {


  final Offset ScreenDim = Offset(414.0,896.0);

  //
  // void _ClearSuggestions() {
  //   setState(() {
  //     _Suggestions.clear();
  //   });
  // }
  //
  // void _SetSuggestions(List<String> newSuggestions){
  //   setState( (){
  //     _Suggestions = newSuggestions;
  //   });
  // }
  // void _AddSuggestion(String ASuggestion) {
  //   setState(() {
  //     _Suggestions.add(ASuggestion);
  //   });
  // }

  @override

  Widget build(BuildContext context){
    return Container(
      height: 65, ////
      child:  Consumer<StrokesToSuggestion>(
        builder: (context,stroke2Sug, child)=> ListView.builder(
          shrinkWrap: true,
          // padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          // physics :const BouncingScrollPhysics(), dont need it
          itemCount: stroke2Sug.Suggestions.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              width: 50, //ScreenDim.dy,
              height: 60,
              color: Colors.grey,
              padding: const EdgeInsets.all(5.0) ,
              child: ListTile(
                title: Text(stroke2Sug.Suggestions[index],
                  style: new TextStyle(fontSize: 30),

                ),
                onTap: () {
                  // widget.Suggestions.add( widget.Suggestions[index]);
                  // print(widget.Suggestions.last);
                  widget.tappedLetterCallback( stroke2Sug.Suggestions[index]);

                }
              ),
            );
          }
        ),
      )
    );
    // return ListView(
    //   children: _Suggestions,
    //   scrollDirection: Axis.horizontal,
    // )
  }
}