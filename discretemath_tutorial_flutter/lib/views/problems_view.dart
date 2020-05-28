import 'package:flutter/material.dart';

class ProblemsView extends StatefulWidget {


  _ProblemsViewState createState() => _ProblemsViewState();
}

class _ProblemsViewState extends State<ProblemsView> {
  var currentPanelIndex = -1;
  List<int> mList;   //组成一个int类型数组，用来控制索引
  List<ExpandStateBean> expandStateList;    //开展开的状态列表， ExpandStateBean是自定义的类
  //构造方法，调用这个类的时候自动执行
  _ProblemsViewState(){
    mList = new List();
    expandStateList = new List();
    //便利为两个List进行赋值
    for(int i=0;i<10;i++){
      mList.add(i);
      expandStateList.add(ExpandStateBean(i,false));
    }
  }
  //修改展开与闭合的内部方法
  _setCurrentIndex(int index, isExpand){
    setState(() {
      //遍历可展开状态列表
      expandStateList.forEach((item){
        if(item.index==index){
          //取反，经典取反方法
          item.isOpen = !isExpand;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
            title:Center(child: Text("我的题库")
            ),
          elevation: 0,
        ),
        //加入可滚动组件
        body:SingleChildScrollView(
          child: ExpansionPanelList(
            //交互回掉属性，里边是个匿名函数
            expansionCallback: (index,bol){
              //调用内部方法
              _setCurrentIndex(index, bol);
            },
            children: mList.map((index){//进行map操作，然后用toList再次组成List
              return ExpansionPanel(
                  headerBuilder: (context,isExpanded){
                    return ListTile(
                        title:Text('谓词逻辑 $index')
                    );
                  },
                  body:ListTile(
                      title:Text('题型选项')
                  ),
                  isExpanded: expandStateList[index].isOpen
              );
            }).toList(),
          ),
        )

    );
  }
}
//自定义扩展状态类
class ExpandStateBean{
  var isOpen;
  var index;
  ExpandStateBean(this.index,this.isOpen);
}