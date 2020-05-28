//

import 'package:flutter/material.dart';
import 'package:tutorial/pages/aboutme.dart';
import 'package:tutorial/views/problems_view.dart';
import 'package:tutorial/views/settings.dart';

class MyPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('个人中心'),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(
                  Icons.settings,
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
                }),
          ],
        ),

        body: AboutMe(),
        drawer: new Drawer(
          child: HomeBuilder.homeDrawer(),
        ),
    );
  }

}


class HomeBuilder {
  static Widget homeDrawer() {
    return new ListView(padding: const EdgeInsets.only(), children: <Widget>[
      _drawerHeader(),
      new ClipRect(
        child: new ListTile(
          leading: new CircleAvatar(child: new Text("A")),
          title: new Text('个人资料'),
          subtitle: new Text("查看"),
          onTap: () => {},
        ),
      ),
      new ListTile(
        leading: new CircleAvatar(child: new Text("B")),
        title: new Text('学习报告'),
        subtitle: new Text("自动生成"),
        onTap: () => {},
      ),
      new AboutListTile(
        icon: new CircleAvatar(child: new Text("Ab")),
        child: new Text("聊天记录"),
        applicationName: "Test",
        applicationVersion: "1.0",
        applicationIcon: new Image.asset(
          "",
          width: 64.0,
          height: 64.0,
        ),
        applicationLegalese: "applicationLegalese",
        aboutBoxChildren: <Widget>[
          new Text("BoxChildren"),
          new Text("box child 2")
        ],
      ),
    ]);
  }

  static Widget _drawerHeader() {
    return new UserAccountsDrawerHeader(
//      margin: EdgeInsets.zero,
      accountName: new Text(
        "华师学子",
      ),
      accountEmail: new Text(
        "feelingcxd@126.com",
      ),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: new AssetImage("assets/logo.png"), //头像
        backgroundColor: Colors.white,
      ),
      onDetailsPressed: () {}, //展示更多
      otherAccountsPictures: <Widget>[
        new CircleAvatar(
          backgroundImage: new AssetImage("assets/emoji.png"),
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

class Goods {
  String imageUrl;

  Goods(this.imageUrl);
}