import 'package:flutter/material.dart';
import 'package:tutorial/pages/index.dart';         // 导入index.dart
import 'package:tutorial/pages/login.dart';
import 'package:tutorial/tools/theme.dart';
// 这里为入口函数
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Discrete Tutorial',
      theme: basicTheme(),
      home: new LoginPage(),     // 指定去加载 Index页面。
    );
  }
}
