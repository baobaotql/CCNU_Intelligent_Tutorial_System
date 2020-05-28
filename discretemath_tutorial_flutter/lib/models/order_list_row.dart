import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/tools/RgbaColor.dart';
import 'package:tutorial/tools/theme.dart';

class OrderListRow extends StatelessWidget {
  final int lessonStatus;
  final String lessonName;///课程名称
  final String lessonNum;///课程编号
  final String lessonContent;///课程内容
  final Function onPress;


  OrderListRow(this.lessonStatus, {
    this.lessonName,
    this.lessonNum,
    this.lessonContent,
    this.onPress
  });


  /// 文字状态
  Widget textStatus() {
    var text = '';
    var color =  MyColors.blueTitle;
    if(lessonStatus == 1) {
      color = rgba(136, 175, 213, 1);
      text = "去学习";
    }
    else if(lessonStatus == 2) text = "已学习";
    else if(lessonStatus == 3) text = "已取消";

    return Text(text, style: TextStyle(
        fontSize: 15,
        color: color
    ));
  }

  /// 按钮状态
  List<Widget> buttonStatus(BuildContext context) {
    List<Widget>button = [];

    var btn1 = Container(
      margin: EdgeInsets.only(left: 10),

    );

    var btn2 = Container(
      margin: EdgeInsets.only(left: 10),

    );

    var btn3 = Container(
      margin: EdgeInsets.only(left: 10),

    );

    if(lessonStatus == 1) {
      button.add(btn2);
    } else if(lessonStatus == 2) {
      button.add(btn1);
      button.add(btn3);
    } else if(lessonStatus == 3) {
      button.add(btn1);
    }
    return button;

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left:30.0,right: 30.0,top: 30.0),
      child: InkWell(
        onTap: (){},
        child: Container(
          height: 160,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 19.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color.fromARGB(255, 249, 249, 249),
            boxShadow: [
              BoxShadow(
                color:Colors.black12,
                blurRadius: 10.0,
                offset: Offset(10,10)
              )
            ]
          ),
          child: Column(
            children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                //border: G.borderBottom()
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('课程编号：$lessonNum', style: TextStyle(
                      color:MyColors.greenTitle.withBlue(100).withAlpha(200),
                      fontSize: 14
                  ),
                  ),
                  textStatus()
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('$lessonName', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    color: MyColors.greenTitle
                  )
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: Text(lessonContent,style: TextStyle(
                          fontSize: 15,
                          color:MyColors.goodGray
                      ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,),
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
