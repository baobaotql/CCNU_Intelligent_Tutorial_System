import 'package:flutter/material.dart';

class myMistake extends StatefulWidget {
  myMistake({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<myMistake> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black26,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    isScrollable: true, //多个Tab的时候，可以实现滑动和联动
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(text: "热销"),
                      Tab(text: "推荐"),
                      Tab(text: "推荐")
                    ],
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  ListTile(title: Text("第一个tab")),
                ],
              ),
              ListView(
                children: <Widget>[
                  ListTile(title: Text("第二个tab")),
                ],
              ),
              ListView(
                children: <Widget>[
                  ListTile(title: Text("第三个tab")),
                ],
              ),
            ],
          )),
    );
  }
}
