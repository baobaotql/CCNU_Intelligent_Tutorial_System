import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/views/chapters_view.dart';
import 'package:tutorial/views/problems_view.dart';
import 'package:tutorial/views/quiz_category.dart';
import 'package:tutorial/views/quiz_view.dart';
import 'package:tutorial/views/settings.dart';
import 'package:tutorial/views/ti.dart';

/*
* 我的学习（下一级页面）
*        我的练习题
* */
class StudyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudyPageState();
  }
}

class _StudyPageState extends State<StudyPage> with SingleTickerProviderStateMixin{

  TabController _tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
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
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            title: new TabBar(
              controller: _tabController,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor:  Theme.of(context).indicatorColor,
              labelStyle: TextStyle(fontSize: 19,),

              tabs: <Tab>[
                new Tab(text: "我的题库",),
                new Tab(text: "我的错题",),
                new Tab(text: "我的收藏",)
              ],

            ),

          ),
          preferredSize: Size.fromHeight(50)),

      body: getTabBarView(
          <Widget>[
            QuizCategory(),
//            ChaptersView(),
            CuoTi(),
            ProblemsView(),
          ]
      ),
    );
  }

}
