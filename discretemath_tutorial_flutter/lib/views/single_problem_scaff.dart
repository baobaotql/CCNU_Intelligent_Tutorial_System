import 'package:flutter/material.dart';
import 'package:tutorial/models/data.dart';
import 'package:tutorial/views/chat_view.dart';
import 'package:tutorial/views/problem_panel.dart';
class SingleProblemView extends StatefulWidget {
  const SingleProblemView(
      {Key key, this.problemId})
      : super(key: key);

  final String problemId;

  @override
  _SingleProblemViewState createState() => _SingleProblemViewState();
}

class _SingleProblemViewState extends State<SingleProblemView> {

  bool _show = false;
  PersistentBottomSheetController sheetController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:  scaffoldKey,
      appBar: AppBar(
        title: Text('题目编号：'+widget.problemId),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
            DummyDataService.tempProblems = null;
          },
          child: Icon(Icons.arrow_back_ios,
          ),
        ),
      ),
      body: QuizProblemCQ(
        problemId: widget.problemId,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.people_outline,color: Theme.of(context).primaryColor,),
          onPressed: () {
            if (!_show){
              _show = true;
              sheetController = scaffoldKey.currentState.showBottomSheet((context) =>
                  ChatView());
              sheetController.closed.then((value) {
                print('sheet closed');
                _show=false;
              });
            }else{
              sheetController.close();
              _show=false;
            }
          }
      ),
    );
  }
}
