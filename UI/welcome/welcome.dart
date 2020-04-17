import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child:Image.asset("images/logo.png",
//                      width:390,
//                      height:390,
                      alignment: Alignment.center,
                      fit:BoxFit.scaleDown
                  ),
                ),
              ],
            )
        )
    );
  }
}