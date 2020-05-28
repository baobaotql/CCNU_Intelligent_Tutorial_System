import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/models/data.dart';
import 'package:tutorial/tools/theme.dart';
// 答题界面抽屉：展示所有题目
class ProblemsList extends StatefulWidget {
  final String currentProblemId;
  final ValueChanged<String> onCategoryTap;
  final String chapterId;
  ProblemsList({
    Key key,
    @required this.currentProblemId,
    @required this.onCategoryTap,
    this.chapterId,
  })  :assert(onCategoryTap != null);

  @override
  _ProblemsListState createState() => _ProblemsListState();
}

class _ProblemsListState extends State<ProblemsList> {

  List<Problem> _problems;
  bool openSubCate = false;

  initState() {
    _getData(widget.chapterId);
  }

  Future _getData(String problemId) async{
    _problems = await DummyDataService.getProblemListByChapter(widget.chapterId);
    widget.onCategoryTap(_problems[0].id);
    setState(() {
      _problems = _problems;
    });
  }

  Widget _buildCategory(Problem problem, BuildContext context) {
    String problemId = problem.id;
    String description = problem.description;
    final problemString = problemId; //TODO 展示题目关键词
    final ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () => widget.onCategoryTap(problemId),
      child: Material(
            color: Theme.of(context).cardColor.withAlpha(220),
            elevation: widget.currentProblemId == problemId
                ? 10.0:2.0,
            shadowColor: widget.currentProblemId == problemId
                ?Color(0x802196F3):Color(0xff319fF3),
            borderRadius: BorderRadius.circular(24.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    problemString,
                    style: theme.textTheme.headline2.copyWith(
//                    textAlign: TextAlign.center,
                    fontWeight: widget.currentProblemId == problemId
                        ?FontWeight.bold:FontWeight.normal,
                        fontSize: widget.currentProblemId == problemId
                            ?22:20,
                    color: widget.currentProblemId == problemId
                        ? Theme.of(context).accentColor:
                    Colors.white),
                  ),
                ),
              ),
            ),
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 40.0),
        decoration: BoxDecoration(gradient: LinearGradient(colors:[Colors.greenAccent, Colors.lightBlueAccent])),
        child: _problems!=null?StaggeredGridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 10.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
          children: _problems .map((Problem p) => _buildCategory(p, context))
              .toList(),
          staggeredTiles:_problems.map((e) =>
          StaggeredTile.extent(1, 70)).toList(),
        ):Container(),
    ),
    );
  }
}