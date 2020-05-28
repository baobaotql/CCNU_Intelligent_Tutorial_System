import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/pages/login.dart';


import 'package:tutorial/pages/study_page.dart';
import 'package:tutorial/pages/my_page.dart';
import 'package:tutorial/pages/home_page.dart';

import '../views/navigation_icon_view.dart'; // 如果是在同一个包的路径下，可以直接使用对应的文件名

// 创建一个 带有状态的 Widget Index
class Index extends StatefulWidget {

  //  固定的写法
  @override
  State<StatefulWidget> createState()  => new _IndexState();
}

// 要让主页面 Index 支持动效，要在它的定义中附加mixin类型的对象TickerProviderStateMixin
class _IndexState extends State<Index> with TickerProviderStateMixin{

  int _currentIndex = 0;    // 当前界面的索引值
  List<NavigationIconView> _navigationViews;  // 底部图标按钮区域
  List<StatefulWidget> _pageList;   // 用来存放我们的图标对应的页面
  StatefulWidget _currentPage;  // 当前的显示页面

  SharedPreferences sharedPreferences;

  // 定义一个空的设置状态值的方法
  void _rebuild() {
    setState((){});
  }
  @override



  // 初始化导航图标
  void initState() {
    super.initState();
    checkLoginState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(icon: new Icon(Icons.home), title: new Text("首页"), vsync: this), // vsync 默认属性和参数
      //new NavigationIconView(icon: new Icon(Icons.all_inclusive), title: new Text("想法"), vsync: this),
      new NavigationIconView(icon: new Icon(Icons.local_library), title: new Text("我的学习"), vsync: this),
      //new NavigationIconView(icon: new Icon(Icons.add_alert), title: new Text("通知"), vsync: this),
      new NavigationIconView(icon: new Icon(Icons.person), title: new Text("我的"), vsync: this),
    ];

    // 给每一个按钮区域加上监听
    for (NavigationIconView view in _navigationViews) {
      view.controller.addListener(_rebuild);
    }

    // 将我们 bottomBar 上面的按钮图标对应的页面存放起来，方便我们在点击
    _pageList = <StatefulWidget>[
      new HomePage(),
      new StudyPage(),
      new MyPage()
    ];
    _currentPage = _pageList[_currentIndex];
  }

  checkLoginState() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token")==null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (route) => false);
    }
  }

  @override
  // 声明定义一个 底部导航的工具栏
  Widget build(BuildContext context) {
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationIconView) => navigationIconView.item)
          .toList(),  // 添加 icon 按钮
      currentIndex: _currentIndex,  // 当前点击的索引值
      type: BottomNavigationBarType.fixed,    // 设置底部导航工具栏的类型：fixed 固定
      onTap: (int index){   // 添加点击事件
        setState((){    // 点击之后，需要触发的逻辑事件
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
          _currentPage = _pageList[_currentIndex];
        });
      },
    );

    return new Scaffold(
        body: new Center(
            child: _currentPage   // 动态的展示我们当前的页面
        ),
        bottomNavigationBar: bottomNavigationBar,   // 底部工具栏
    );
  }

}