import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/models/data.dart';
import 'package:tutorial/tools/theme.dart';
import 'package:tutorial/views/settings.dart';

class AboutMe extends StatefulWidget {
  @override
  _AboutMeState createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {

  static String username;

  @override
  void initState() {
    super.initState();
  }

  _getData() async{
    username = await DummyDataService.getUid();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: <Widget>[
            stack,
            new ListTile(
              leading:new Icon(
                Icons.timeline,
                color: Colors.blue,
              ),
              title:new Text('学习时长：20h',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            new ListTile(
              leading:new Icon(
                Icons.question_answer,
                color: Colors.blue,
              ),
              title:new Text('累计答题：520题',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            new ListTile(
              leading:new Icon(
                Icons.book,
                color: Colors.blue,
              ),
              title:new Text('掌握知识点：100个',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget stack = Container(
    color: Color(0xff0da56d),
    child: Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Image.asset(
            'assets/bg.jpeg',
            height: 240.0,
            fit: BoxFit.cover,
          ),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(
                'assets/logo.png'
            ),
          ),
          Positioned(
            bottom: 20,
            child: Text(
              '华师学子',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
    ),
  );
}
