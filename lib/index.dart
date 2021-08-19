import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cal.dart';
//StatefulWidget有状态  StatelessWidget无状态
class IndexPage extends StatefulWidget {
  //黑色背景颜色
  static const Color PAGE_COLOR = Colors.black;

  //数字键黑色背景
  static const Color NUM_BTN_BG = Color(0xff323232);

  //按键分布
  static const NKEYS = [
    "C", "D", "?", "/", //
    "9", "8", "7", "*", //
    "6", "5", "4", "-", //
    "3", "2", "1", "+", //
    "", "0", ".", "="
  ]; //
  //顶部按钮
  static const TKeys = ["C", "D", "?"];

  //右侧按钮
  static const RKeys = ["/", "*", "-", "+", "="];

  //右侧运算符背景
  static const Color RIGHT_BTN_BG = Color(0xFFff9500);

  //顶部按键颜色
  static const Color TOP_BTN_BG = Color(0xFFa6a6a6);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  //显示内容
  String _num="";
  //实例化私有变量
  Cal _cal=new Cal();
  void clickKey(String key){
  _cal.addKey(key);

  setState(() {
    //通知输出,但是在内还是在外都可以用，还需要进一步学习
    _num=_cal.OutPut;
  });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //修改背景为黑色
      backgroundColor: IndexPage.PAGE_COLOR,
      //标题
      appBar: AppBar(
        title: Text('第一个计算器'),
        //标题背景
        backgroundColor: IndexPage.PAGE_COLOR,
        //标题居中
        centerTitle: true,
      ),
      //Padding：增加主体与手机的距离
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          //child: Text('hello wold'),
          //Column可以让子组件逐行显示
          child: Column(
            children: <Widget>[
              //Expanded填充整个页面
              Expanded(
                //增加显示的滚动组件
                  child: SingleChildScrollView(
                    //设置自动滚动到底部，方法的属性
                    reverse: true,
                    //增加和边框的间距
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),//水平 垂直
                      child: Align(
                        //右下角显示
                          alignment: Alignment.bottomRight,
                          child: Text(
                            '$_num',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          )),
                    ),
                  )),
              Container(child: Center(child: buildBtns()))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFlatButton(String num, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        //按键触发
        onPressed: () => {
          clickKey(num)
        },
        //
        padding: EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
              color: IndexPage.TKeys.contains(num)
                  ? IndexPage.TOP_BTN_BG
                  : IndexPage.RKeys.contains(num)
                      ? IndexPage.RIGHT_BTN_BG
                      : IndexPage.NUM_BTN_BG,
              //设置形状
              shape: flex > 1 ? BoxShape.rectangle : BoxShape.circle,
              //设置边角，只能对矩形生效
              borderRadius:
                  flex > 1 ? BorderRadius.all(Radius.circular(1000)) : null),
          padding: EdgeInsets.all(20),
          //行间距变大了但是按钮变小了，再将padding置0
          margin: EdgeInsets.all(10),
          child: Center(
              child: Text(
            "$num",
            style: TextStyle(fontSize: 28, color: Colors.white),
          )),
        ),
      ),
    );
  }

  Widget buildBtns() {
    List<Widget> rows = [];

    List<Widget> btns = [];
    int flex = 1;
    for (int i = 0; i < IndexPage.NKEYS.length; i++) {
      String key = IndexPage.NKEYS[i];
      if (key.isEmpty) {
        flex++;
        continue;
      }
      //画按钮
      Widget btn = buildFlatButton(key, flex: flex);
      btns.add(btn);
      flex = 1;
      if ((i + 1) % 4 == 0) {
        rows.add(Row(
          children: btns,
        ));
        btns = [];
      }
    }
    if (btns.length > 0) {
      rows.add(Row(
        children: btns,
      ));
      btns = [];
    }
    return Column(
      children: rows,
    );
  }
}
