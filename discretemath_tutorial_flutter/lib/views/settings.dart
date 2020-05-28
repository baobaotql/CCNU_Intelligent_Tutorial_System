import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/pages/login.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences sharedPreferences;

  void initState() {
    super.initState();
    _init();
  }

  _init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('设置中心')),
      ),
      body: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                title: new Text(
                  '消息中心', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text('查看您的最近通知'),
                leading: new Icon(Icons.message, color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title: new Text(
                  '个人资料', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text('查看自己的个人资料信息'),
                leading: new Icon(Icons.account_box, color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title: new Text(
                  '学习兴趣', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text('选择自己感兴趣的学习'),
                leading: new Icon(Icons.check, color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title: new Text(
                  '设置', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text('关于app的设置'),
                leading: new Icon(Icons.settings, color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title: new Text(
                  '意见反馈', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text('提供您对app的意见信息'),
                leading: new Icon(Icons.share, color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title: new Text(
                  '给智能导学app评价', style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: new Text('提供您的使用感受'),
                leading: new Icon(Icons.link, color: Colors.lightBlue,),
              ),
              new Divider(),
              ListTile(
                title: Center(
                  child: GestureDetector(
                    onTap: ()=>_signOut(context),
                    child: new Text(
                      '注销', style: TextStyle(fontWeight: FontWeight.w500,color: Colors.redAccent),),
                  ),
                ),
              ),
              new Divider(),
            ],
          ),
        ),

      ),
    );
  }

  _signOut(context) {
    sharedPreferences.clear();
    sharedPreferences.commit();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()), (route) => false);
  }
}