import 'package:bubble/bubble.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial/tools/theme.dart';
import 'package:tutorial/views/default_extra_item.dart';
import 'package:tutorial/views/input_widget.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:ui' as ui;
class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  ChatType currentType;
  TextEditingController ctl = TextEditingController();
  List<Map<String, dynamic>> _messages = [
    {'sender':'ccnu','type':'text','content': '你好'},
    {'sender':'ccnu','type':'img','content': 'assets/emoji.png'}
  ];
  String cur_uid = '1';
  SharedPreferences sharedPreferences;
  
  @override
  void initState() {
    super.initState();
    ctl.addListener(onValueChange);
    _getData();
  }

  void dispose() {
    ctl.removeListener(onValueChange);
    ctl.dispose();
    super.dispose();
  }

  _getData()async{
    sharedPreferences = await SharedPreferences.getInstance();
    cur_uid = sharedPreferences.getString('uid');
    print(cur_uid);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ChangeChatTypeNotification>(
      onNotification: _onChange,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child:Column(
                        children: [
                          SizedBox(height: 25.0,),
                          Column(
                            children:  _messages.map((e) =>
                                cur_uid==e['sender']? Bubble(  //用户气泡
                                  margin: BubbleEdges.only(top: 10),
                                  child: e['type']=='text'?Text(e['content'],style: TextStyle(color: Colors.black),): Image.asset(e['content']),
                                  color: Theme.of(context).accentColor,
                                  alignment: Alignment.topRight,
                                  nip: BubbleNip.rightTop,
                                ):e['sender']=='_notice'?
                                      e['type']=='button'?Row(       //Suggestions
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children:e['content'].map<Widget>((m)=>Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: ActionChip(
                                            backgroundColor: Colors.black.withOpacity(0.5),
                                            onPressed: (){},
                                            avatar: Icon(Icons.location_searching),
                                            label: Text(m,style: TextStyle(color: Colors.white70),),
                                          ),
                                        )).toList(),
                                      )
                                      :
                                      Bubble(  //通知
                                        margin: BubbleEdges.only(top: 10),
                                        alignment: Alignment.center,
                                        color: Color.fromRGBO(212, 234, 244, 1.0),
                                        child:e['type']=='text'?Text(e['content'],textAlign:TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16.0),): Image.asset(e['content']),
                                ):
                                e['content'].runtimeType == String?
                                Bubble( // 解释
                                  margin: BubbleEdges.only(top: 10,left: 10),
                                  alignment: Alignment.topLeft,
                                  nip: BubbleNip.leftTop,
                                  child:e['type']=='text'?
                                  Text(
                                      e['content'],
                                      style: TextStyle(color: Colors.black),
                                  ) : Image.asset(e['content']),
                                ):
                                Bubble( // 解释
                                  margin: BubbleEdges.only(top: 10,left: 10),
                                  alignment: Alignment.topLeft,
                                  nip: BubbleNip.leftTop,
                                  child:e['type']=='text'?
                                  e['content'].map<Widget>((m)=>TextSpan(
                                      text: m,
                                      style: TextStyle(color: Color.fromRGBO(212, 234, 244, 1.0)),
                                    recognizer: TapGestureRecognizer()..onTap = (){
                                      print("send text $m");
                                      _messages.add({'sender':cur_uid,'type':'text','content':m.toString()});
                                      setState(() {});
                                      _dialogFlowResponse(m.toString());
                                    }
                                  )).toList()
                                      : Image.asset(e['content']),
                                )
                            ).toList(),
                          ),
                          SizedBox(height: 25.0,)
                        ],
                      ),
                    ),
                ),
                InputWidget(
                  controller: ctl,
                  extraWidget: DefaultExtraWidget(),
                  onSend: (value){
                    ctl.clear();
                    print("send text $value");
                    _messages.add({'sender':cur_uid,'type':'text','content':value.toString()});
                    setState(() {});
                    _dialogFlowResponse(value.toString());
                  },
                ),
              ],
          ),
        ),
      )
    );
  }

  void onValueChange() {
  }

  bool _onChange(ChangeChatTypeNotification notification) {
    setState(() {
      this.currentType = notification.type;
    });
    return true;
  }

  void _dialogFlowResponse(String query)  async{
      AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/flutterapp-cxd-83c9f1a2b07f.json").build();
      Dialogflow dialogflow = Dialogflow(
        authGoogle: authGoogle,
        language: Language.chineseSimplified
      );
      AIResponse response = await dialogflow.detectIntent(query);
      String message = response.getMessage()??response.getMessage();
      var fulfillments = response.queryResult.fulfillmentMessages;
      String explain;
      List<String> suggestions;
      print(message);
      print(fulfillments);
      if(fulfillments!=null){
        explain = fulfillments.length>0?fulfillments[0]['text']['text'][0]:null;
        suggestions = fulfillments.length>1?fulfillments[1]['quickReplies']['quickReplies'][0].split(','):null;
      }
      String intent = response.queryResult.intent.displayName;
      String entity = response.queryResult.parameters['entity'];
      print(message);
      if ((intent!=null || entity!=null)&&intent!="Default Welcome Intent"&&intent!="Default Fallback Intent"&&intent!="用户懂了")
        _messages.add({'sender':'_notice','type':'text','content':"您想要：${intent}（${entity}）"});
      if (message!=null)
        _messages.add({'sender':'robot','type':'text','content':message});
      else{
        if (explain!=null){
          List exs = explain.split("<a>");
          _messages.add({'sender':'robot','type':'text','content':exs});
        }
        if (suggestions!=null){
          _messages.add({'sender':'_notice','type':'text','content':"相关概念："});
          _messages.add({'sender':'_notice','type':'button','content':suggestions});
        }
      }
      setState(() {});
      print(_messages);
      _saveMessagesToCloud();
  }

  void _saveMessagesToCloud(){
    //TODO
  }

}
