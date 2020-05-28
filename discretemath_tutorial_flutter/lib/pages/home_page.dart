import 'package:flutter/material.dart';
import 'package:tutorial/models/order_list_row.dart';
import 'package:tutorial/views/recommend.dart';
import 'package:tutorial/views/video_resource.dart';
//import 'package:fluttertest2/RgbaColor.dart';

//class HomePage extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() => new _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('首页'),
//          actions: <Widget>[
//            new Container()
//          ],
//        ),
//        body: new Center(
//          child: null,
//        ),
//      ),
//    );
//  }
//}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabBarView getTabBarView(var tabs){

    return TabBarView(
      children: tabs,
      controller: _tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new  PreferredSize(
          child: new AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
            title: TabBar(
              controller: _tabController,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Theme.of(context).indicatorColor,
              labelStyle: TextStyle(fontSize: 19,),
              tabs: <Tab>[
                new Tab(text: "个性推荐",),
                new Tab(text: "课程",)
              ],

              ),

          ),
          preferredSize: Size.fromHeight(50)),

      body: getTabBarView(
          <Widget>[
            RecommendView(),
            VideoRecommend()
        ]
      ),
    );
  }

}
