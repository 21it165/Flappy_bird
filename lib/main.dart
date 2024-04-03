import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, Widget, runApp;

import 'HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });
 
  @override
  Widget build(BuildContext context){
     return const MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HomePage(),
     );
  }
}

