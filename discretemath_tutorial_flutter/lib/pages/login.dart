/*
 * 登录界面
 */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/models/data.dart';
import 'package:tutorial/pages/index.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObscure = true;
  Color _eyeColor;
  bool _isLoading = false;

  SharedPreferences sharedPreferences;

  void initState() {
    super.initState();
    checkLoginState();
  }

  checkLoginState() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token")!=null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>Index()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
//        backgroundColor: Colors.white,
          body: _isLoading?Center(
            child: CupertinoActivityIndicator(
              radius: 18.0,
            ),
          ):Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  BuildTitle(),
                  BuildTitleLine(),
                  SizedBox(height: 70.0),
                  BuildEmailTextField(),
                  SizedBox(height: 30.0),
                  buildPasswordTextField(context),
                  buildForgetPasswordText(context),
                  SizedBox(height: 60.0),
                  buildLoginButton(context),
                  SizedBox(height: 30.0),
                  buildOtherLoginText(),

                  buildRegisterText(context),
                ],
              ))),
    );
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                print('去注册');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }



  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '学校账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '登录',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              //TODO 执行登录方法
              setState(() {
                _isLoading = true;
              });
              print('---${_email.trim()}---${_password.trim()}');
              signIn(_email, _password);
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            //TODO
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                  _eyeColor = _isObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField  BuildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Emall Address',
      ),
      validator: (String value) {
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        if (!emailReg.hasMatch(value)) {
          return '请输入正确的邮箱地址';
        }
      },
      onSaved: (String value) => _email = value,
    );
  }

  Padding BuildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 80.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding BuildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Text(
            '登录',
            style: TextStyle(fontSize: 45.0),
          ),
          Positioned(
            right: 10,
            top: -40,
            child: Container(
              width: 200,
              height: 200,
              child: Image.asset(
                  'assets/logo.png'
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signIn(String email,String password) async{
    Map data = {
      "email": email.trim(),
      "password": password.trim()
    };
    var response = await http.post("https://discretemath-app.herokuapp.com/api/login", body: jsonEncode(data),
      headers: {
      "Content-Type": "application/json"
    },);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData = null;
    if (response.statusCode==200){
      jsonData = jsonDecode(response.body);
      if (jsonData['status']=='success'){
        print(jsonData['token']);
        setState(() {
          _isLoading = false;
          sharedPreferences.setString("token", jsonData['token']);
          sharedPreferences.setString("uid", jsonData['uid']);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context)=>Index()),
                  (Route<dynamic> route )=>false);
        });
      }else{
//TODO toast error
      print(jsonData['status']+jsonData['err']+jsonData['message']);
        setState(() {
          _isLoading = false;
        });
      }
    }else{
      print("not 200");
      setState(() {
        _isLoading = false;
      });
// TODO toast error
    }
  }
}
