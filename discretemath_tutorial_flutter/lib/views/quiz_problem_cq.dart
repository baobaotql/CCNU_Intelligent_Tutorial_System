import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/models/data.dart';
// 选择题（单选）界面
class QuizProblemCQ2 extends StatefulWidget {
  const QuizProblemCQ2(
      {Key key, this.problem,this.onCategoryTap})
      : super(key: key);

  final Problem problem;
  final ValueChanged<String> onCategoryTap;

  @override
  _QuizProblemCQ2State createState() => _QuizProblemCQ2State();
}

class _QuizProblemCQ2State extends State<QuizProblemCQ2> {

  bool _answered = false;

  Widget _buildOptionView(var option, BuildContext context) {
    return GestureDetector(
      onTap: (){
        _answered = true;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Center(
            child: Container(
              height: 50.0,
              color: Theme.of(context).cardColor ,
              child: InkWell(
                // TODO 做题
                onTap: (){
                  _answered = true;
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Container(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.only(left:15.0,top:15.0,bottom: 15.0,right: 15.0),
                          child: Center(child:
                          !_answered?Text(option.key,style: Theme.of(context).textTheme.bodyText2.copyWith(letterSpacing: 5.0))
                              :Icon(Icons.check)
                          ),
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
    return Container(
//      color: Theme.of(context).canvasColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: ()=>widget.onCategoryTap(widget.problem.id),
                child: Container(color:Colors.green.withAlpha(0),height: 35,))
            ,
            Container(
              height: 250,
              child:widget.problem!=null?Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        widget.problem!=null?widget.problem.description:'',
                        style: textTheme.bodyText1,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                      child: Text(
                        widget.problem!=null?widget.problem.question:'',
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
                children:widget.problem!=null?widget.problem.options.entries
                    .map((var c) => _buildOptionView(c, context))
                    .toList():[]),
          ],
        ),
      ),
    );
  }
}