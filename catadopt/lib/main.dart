import 'package:flutter/material.dart';
import 'package:catadopt/ui/cat_list.dart';

void main() => runApp(CatAdoptApp());

class CatAdoptApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(theme: new ThemeData(
      primarySwatch: Colors.blue,
      accentColor: Colors.pinkAccent,
      fontFamily: 'Ubuntu'

    ),
    home: new CatList(),
    );
    
  }
}

