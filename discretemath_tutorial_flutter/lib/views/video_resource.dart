import 'package:flutter/material.dart';
import 'package:tutorial/models/order_list_row.dart';

class VideoRecommend extends StatefulWidget {
  @override
  _VideoRecommendState createState() => _VideoRecommendState();
}

class _VideoRecommendState extends State<VideoRecommend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )
        ),
        child: ListView(
          children: <Widget>[
            OrderListRow(1,
              lessonNum: '23847563928177',
              lessonName: '集合论 | 视频',
              lessonContent: '集合论，是数学的一个基本的分支学科，研究对象是一般集合。集合论在数学中占有一个独特的地位，它的基本概念已渗透到数学的所有领域。',
            ),
            OrderListRow(1,
              lessonNum: '23847563928174',
              lessonName: '图论 | PDF',
              lessonContent: '图论〔Graph Theory〕是数学的一个分支。它以图为研究对象。图论中的图是由若干给定的点及连接两点的线所构成的图形，这种图形通常用来描述某些事物之间的某种特定关系',
            ),
            OrderListRow(1,
              lessonNum: '23847563928175',
              lessonName: '形式语言与自动机 | PDF',
              lessonContent: '形式语言主要包含四类形式语言短语结构语言、上下文有关语言、上下文无关语言、正则语言；自动机包含有穷自动机、下推自动机、图灵机、线性有界自动机',
            ),
            OrderListRow(1,
              lessonNum: '23847563928176',
              lessonName: '关系',
              lessonContent: '关系的性质：（1）自反性（2）对称性（3）传递性，以及由此派生出的其他性质。',
            ),
            OrderListRow(1,
              lessonNum: '23847563928178',
              lessonName: '命题逻辑',
              lessonContent: '命题逻辑是指以逻辑运算符结合原子命题来构成代表“命题”的公式，以及允许某些公式建构成“定理”的一套形式“证明规则”。',
            ),
            OrderListRow(1,
              lessonNum: '23847563928179',
              lessonName: '一阶逻辑',
              lessonContent: '一阶逻辑(first order logic,FOL)也叫一阶谓词演算，允许量化陈述的公式，是使用于数学、哲学、语言学及计算机科学中的一种形式系统。',
            ),
          ],
        ),
      ),
    );
  }
}
