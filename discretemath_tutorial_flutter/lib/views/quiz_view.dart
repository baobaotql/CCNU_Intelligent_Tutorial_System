import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial/models/data.dart';
import 'package:tutorial/views/backdrop.dart';
import 'package:tutorial/views/problem_panel.dart';
import 'package:tutorial/views/problems_list.dart';
import 'package:tutorial/views/quiz_problem_cq.dart';
// 答题界面入口
class QuizView extends StatefulWidget {

  final String chapterId;
  final String chapterText;

  QuizView({this.chapterId,this.chapterText});

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {

    String _currentProblemId;//TODO hardcode
    Problem _curProblem;

    void _onCategoryTap(String problemId) {
      DummyDataService.curProblem = DummyDataService.tempProblems!=null?DummyDataService.tempProblems.where((p) => p.id.contains(problemId)).toList()[0]:null;
      DummyDataService.curProblemId = problemId;
      setState(() {
        _currentProblemId = problemId;
        _curProblem = DummyDataService.curProblem;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Backdrop(
        currentCategory: _currentProblemId,
        title: widget.chapterText,
        frontLayer: QuizProblemCQ2(
          problem: _curProblem,
          onCategoryTap: _onCategoryTap,
        ),
        backLayer: ProblemsList(
          currentProblemId: _currentProblemId,
          onCategoryTap: _onCategoryTap,
          chapterId: widget.chapterId,
        ),
        //Container(),
        frontTitle: Text('SHRINE'),
        backTitle: Text('MENU'),
      );
  }
}

