import 'package:flutter/material.dart';

class ChaptersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar:AppBar(
          title:Text('具体章节（如图论）',style: TextStyle(fontSize: 36.0)),
          elevation: 0.0,
        ),
        body:Center(
          child: MaterialButton(
            child: Icon(
              Icons.navigate_next,
              color:Colors.white,
              size:64.0,
            ),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder:(BuildContext context){
                        return SecondPage();
                      }));
            },
          ),
        )
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          title: Text('此页面放具体题目',style:TextStyle(fontSize:36.0),),
          backgroundColor: Colors.pinkAccent,
          leading:Container(),
          elevation: 0.0,
        ),
        body:Center(
          child: MaterialButton(
            child: Icon(
                Icons.navigate_before,
                color:Colors.white,
                size:64.0
            ),
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        )
    );
  }
}