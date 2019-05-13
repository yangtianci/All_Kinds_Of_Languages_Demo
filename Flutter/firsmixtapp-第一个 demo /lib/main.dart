import 'package:flutter/material.dart';

import 'package:english_words/english_words.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
      theme: new ThemeData(
        primaryColor: Colors.pinkAccent,
      ),
    );
  }

//
//  Widget build(BuildContext context) {
//
//    final wordPair = new WordPair.random();
//    return new MaterialApp(
//      title: 'Welcome to Flutter',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//
//        body: new Center(
////          child: new Text(wordPair.asPascalCase),
////            child: new RandomWords(),
//
//        ),
//
//      ),
//    );
//  }
}





class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}


class _RandomWordsState extends State<RandomWords> {
  @override

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 16);

  final _saved = new Set<WordPair>();


  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("列表数据"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
          ],
        ),
        body: _buildSuggestions(),// 此处因为 buil 函数中有返回值, 因此不是 new , 并且 new 一般也是类生成函数时使用, 总之这个位置需要一个 widget , 至于是函数返回还是生成实例, 根据需要制定
      );

  }


  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }



  Widget _buildRow(WordPair pair){
    
    final alreadySaved = _saved.contains(pair),
    
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,

      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }


  Widget _buildSuggestions(){

    return new ListView.builder(
      padding: const EdgeInsets.all(16),

      itemBuilder: (context, i){

        if(i.isOdd) return new Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);

      },

    );

  }

}



