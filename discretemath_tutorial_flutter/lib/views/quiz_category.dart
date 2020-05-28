import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';
import 'package:tutorial/models/data.dart';
import 'package:tutorial/tools/theme.dart';
import 'package:tutorial/views/quiz_view.dart';

const cardTextColor =  Color.fromARGB(255, 22, 209, 233);

class QuizCategory extends StatefulWidget {
  @override
  _QuizCategoryState createState() => _QuizCategoryState();
}

class _QuizCategoryState extends State<QuizCategory> {

  List<Map<String, dynamic>> _categories;

  initState(){
    _getData();
  }

  Future _getData() async{
//    _categories = await DummyDataService.getCategories();
    setState(() {
      _categories = [
        {
          "id": "1",
          "text": "第一章 数理逻辑"
        },
        {
          "id": "2",
          "text": "第二章 集合论"
        },
        {
          "id": "3",
          "text": "第三章 代数结构"
        },
        {
          "id": "4",
          "text": "第四章 组合数学"
        },
        {
          "id": "5",
          "text": "第五章 图论"
        },
        {
          "id": "6",
          "text": "第六章 初等数论"
        }
      ];
    });
  }

  _onMyItemPressed(id, text){
    Navigator.push(context,new  MaterialPageRoute(
        builder:(context) =>new QuizView(
              chapterId: id,
              chapterText: text
        ))
    );
  }

  Material MyItems(IconData icon, String heading, String id){
    return Material(
      color: Theme.of(context).cardColor.withAlpha(220),
      elevation: 2.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: InkWell(
        onTap: ()=>_onMyItemPressed(id, heading),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Icon
                  icon != null ? Material(
                    borderRadius: BorderRadius.circular(24.0),
                    color:  MyColors.blueTitle,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        size: 30.0,
                      ),
                    ),
                  ): Container(),
                  //Text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(heading, style: Theme.of(context).textTheme.headline2),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
        child: Padding(
          padding: const EdgeInsets.only(top:13.0),
          child: _categories==null?
              CupertinoActivityIndicator(
                radius: 15.0,
              ):
          StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            children: _categories.map((e) =>
              (_categories.indexOf(e)==0)? MyItems(null ,e['text'],e['id'])
                  :MyItems(Icons.graphic_eq ,e['text'],e['id'])).toList(),
            staggeredTiles:_categories.map((e) =>
            (_categories.indexOf(e)==0)? StaggeredTile.extent(1, 90)
                :StaggeredTile.extent(1, 180)).toList(),
          ),
        ),
      ),
    );
  }
}
