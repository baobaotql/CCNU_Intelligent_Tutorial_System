import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/models/data.dart';
// 选择题（单选）界面
class QuizProblemCQ extends StatefulWidget {
  const QuizProblemCQ(
      {Key key, this.problemId})
      : super(key: key);

  final String problemId;

  @override
  _QuizProblemCQState createState() => _QuizProblemCQState();
}

class _QuizProblemCQState extends State<QuizProblemCQ> {

  Problem _curProblem;


  initState() {
      _getData();
  }

  Future _getData() async{
    _curProblem = await DummyDataService.getProblemById(widget.problemId);
    setState(() {
    });
  }


  Widget _buildOptionView(var option, BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Center(
            child: Container(
              height: 50.0,
              color: Theme.of(context).cardColor ,
              child: InkWell(
                onTap: (){},
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Container(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.only(left:15.0,top:15.0,bottom: 15.0,right: 15.0),
                          child: Center(child: Text(option.key,style: Theme.of(context).textTheme.bodyText2.copyWith(letterSpacing: 5.0))),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0),
                                  child: Center(child: Text(option.value,style: Theme.of(context).textTheme.bodyText2.copyWith(letterSpacing: 2.0),)),
                                ),
                              ],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
            height: 250,
            child:_curProblem!=null?Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                    child: Text(
                     _curProblem!=null?_curProblem.description:'',
                      style: textTheme.bodyText1,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                    child: Text(
                     _curProblem!=null?_curProblem.question:'',
                      style: textTheme.bodyText1,
                    ),
                  ),
                )
              ],
            ):CupertinoActivityIndicator(
              radius: 15.0,
            ),
          ),
          SizedBox(height: 20),
          ListView(
            scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children:_curProblem!=null?_curProblem.options.entries
                  .map((var c) => _buildOptionView(c, context))
                  .toList():[]),
        ],
      ),
    );
  }
}