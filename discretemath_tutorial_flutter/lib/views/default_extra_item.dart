import 'package:flutter/material.dart';

import 'extra_item_container.dart';

class DefaultExtraWidget extends StatefulWidget {
  @override
  _DefaultExtraWidgetState createState() => _DefaultExtraWidgetState();
}

class _DefaultExtraWidgetState extends State<DefaultExtraWidget> {
  @override
  Widget build(BuildContext context) {
    return ExtraItemContainer(
      items: [
        createitem1(),
        createitem2(),
        createitem3(),
        createitem4(),
      ],
    );
  }

  ExtraItem createitem1() => DefaultExtraItem(
        icon: Icon(Icons.add),
        text: "添加笔记",
        onPressed: () {
          print("添加笔记");
        },
      );

  ExtraItem createitem2() => DefaultExtraItem(
    icon: Icon(Icons.add),
    text: "添加图片",
    onPressed: () {
      print("添加图片");
    },

  );
  ExtraItem createitem3() => DefaultExtraItem(
    icon: Icon(Icons.add),
    text: "拍摄",
    onPressed: () {
      print("拍摄");
    },
  );

  ExtraItem createitem4() => DefaultExtraItem(
    icon: Icon(Icons.add),
    text: "待定功能",
    onPressed: () {
      print("其他");
    },
  );

}

