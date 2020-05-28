import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String host = 'https://discretemath-app.herokuapp.com/';

class AccountData {
  const AccountData({this.name, this.primaryAmount, this.accountNumber});

  /// The display name.
  final String name;

  /// 总分
  final double primaryAmount;

  /// The full displayable account number.
  final String accountNumber;
}

class Problem{
  String id;
  String chapter;
  String type;
  String description;
  String question;
  Map<String, dynamic> options;
  String answer;

  Problem(Map<String, dynamic> data) {
    id = data['id'];
    chapter = data['chapter'];
    type = data['type'];
    description = data['description'];
    question = data['question'];
    options = data['options'];
    answer = data['answer'];
  }
}

class Category {
  const Category({@required this.name, this.children = null})
      : assert(name != null);

  // A function taking a BuildContext as input and
  // returns the internationalized name of the category.
  final String name;
  final List<Category> children;
}

class AnswerData {
  const AnswerData({this.description, this.isCorrect});

  final String description;
  final bool isCorrect;
}



/// Class to return dummy data lists.
///
/// In a real app, this might be replaced with some asynchronous service.
class DummyDataService {

  static List<Problem> tempProblems; //暂存起来，省的展示题目再发请求。
  static Problem curProblem; //暂存起来，省的展示题目再发请求。
  static String curProblemId; //暂存起来，省的展示题目再发请求。
  static String uid; //不要直接访问，使用get方法
  static String token; //不要直接访问，使用get方法

  static Future<String> getUid() async {
    if (uid==null){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();;
      uid = sharedPreferences.getString('uid');
    }
    return uid;
  }

  static Future<String> getToken() async {
    if (token==null){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();;
      token = sharedPreferences.getString('token');
    }
    return token;
  }

  static Future<List<Problem>> getProblemListByChapter(String chapterId) async{
    if (tempProblems==null){
      String mytoken = await getToken();
      http.Response response = await http.get(
          Uri.encodeFull(host+'problems?chapterId='+chapterId),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer "+mytoken
          }
      );
      List data = json.decode(response.body);
      List<Problem> problems = data.map((e) => Problem(e)).toList();
      tempProblems  = problems;
      curProblem = problems[0];
      curProblemId = problems[0].id;
    }
    return tempProblems;
  }

  static Future<List<Map<String, dynamic>>> getCategories() async{
    String mytoken = await getToken();
    http.Response response = await http.get(
        Uri.encodeFull(host+'chapters'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer "+mytoken
        }
    );
    List<Map<String, dynamic>> data = json.decode(response.body);
    return data;
  }

  static Future<List> getWrongProblems() async{
    String userid = await getUid();
    print(userid);
    String mytoken = await getToken();
    print(mytoken);
    http.Response response = await http.get(
        Uri.encodeFull(host+'graph/find/'+userid+'/DidWrong'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer "+mytoken
        }
    );
    print(response.body);
    List data = json.decode(response.body)['data'];
    return data;
  }

  static Future<Problem> getProblemById(String pid) async{
    if (pid==null)
      return null;
    Problem problem;
    if (curProblemId!=pid){
      if (tempProblems!=null){
        List re = tempProblems.where((p) => p.id.contains(pid)).toList();
        if (re.length>0){
          problem = re[0];
        }else{
          String mytoken = await getToken();
          http.Response response = await http.get(
              Uri.encodeFull(host+'problems/'+pid),
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer "+mytoken
              }
          );
          problem = Problem(json.decode(response.body));
          curProblem = problem;
          curProblemId = pid;
        }
      }else{
        String mytoken = await getToken();
        http.Response response = await http.get(
            Uri.encodeFull(host+'problems/'+pid),
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer "+mytoken
            }
        );
        problem = Problem(json.decode(response.body));
        curProblem = problem;
        curProblemId = pid;
      }
    }else{
      problem = curProblem;
    }
    return problem;
  }


  static List<AnswerData> getAnswerSheetDataList() {
    return <AnswerData>[
      AnswerData(description: 'p：吴刚用功', isCorrect: true),
      AnswerData(description: 'q：吴刚聪明', isCorrect: true),
      AnswerData(description: 'r：张辉不是三好生', isCorrect: false),
      AnswerData(description: 's：王丽是三好生', isCorrect: true),
      AnswerData(description: 'p^q', isCorrect: true),
      AnswerData(description: 'p^q', isCorrect: true),
      AnswerData(description: 'q^~p', isCorrect: true),
      AnswerData(description: 'r^s', isCorrect: true),
    ];
  }
}
