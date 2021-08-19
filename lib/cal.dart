class Cal {
  //按键分布
  static const NKEYS = [
    //
    "9", "8", "7", //
    "6", "5", "4", //
    "3", "2", "1", //
    "0", "."
  ]; //
  //顶部按钮
  static const TKeys = ["C", "D", "?"];

  //右侧按钮
  static const RKeys = ["/", "*", "-", "+"];

  //记录上一次输入
  //List<String> _keys = [];

  static const EQ = "=";

  //map定义优先级
  static const Map<String, int> RKeysMap = {"/": 2, "*": 2, "-": 1, "+": 1};

  //显示
  String _output = '';

  String get OutPut => this._output;

  //当前数字
  String _curnum = "";

  //存放结果
  double res = 0;

  //字符串数组，_s1存放数字，_s2存放运算符
  List<String> _s1 = [], _s2 = [];
  List<double> _s3 = [];

  void addKey(String key) {
    if (TKeys.contains(key)) {
      switch (key) {
        case "C":
          _s1 = [];
          _s2 = [];
          _s3 = [];
          _curnum = "";
          _output = "";
          return;
          break;
      }
    }

    //拼数字到_s1
    if (NKEYS.contains(key)) {
      _output += key;
      _curnum += key;
      //_keys.add(key);
    } else {
        _s1.add(_curnum);
        _curnum = "";
        _output += key;

    }
    //处理符号
    if (RKeys.contains(key)) {
      if (_s2.length == 0) {
        _s2.add(key);
      } else {
        //当前运算符优先级小于或等于_s2最末尾的运算符的优先级
        //将_s2的运算符依次从末尾取出，放入_s1
        String lastkey = _s2[_s2.length - 1];
        if (RKeysMap[key]! <= (RKeysMap[lastkey] as int)) {
          //&&后：当多个高等级的运算符在一起会一起出栈

          while (_s2.length > 0 &&
              RKeysMap[key]! <= (RKeysMap[_s2[_s2.length - 1]] as int)) {
            //全部倒序入栈
            _s1.add(_s2.removeLast());
          }
        }
        _s2.add(key);
      }
    }
    //处理等号
    if (EQ == key) {
      while (_s2.length > 0) {
        //全部倒序入栈
        _s1.add(_s2.removeLast());
      }
      //解析_s1中的波兰式（后缀式）
      for (int i = 0; i < _s1.length; i++) {
        String k = _s1[i];
        //是数字：
        if (!RKeys.contains(k)) {
          _s3.add(double.parse(k));
        } else {
          switch (k) {
            case "+":
              _s3.add(_s3.removeLast() + _s3.removeLast());
              break;
            case "*":
              _s3.add(_s3.removeLast() * _s3.removeLast());
              break;
            case "-":
              _s3.add(-(_s3.removeLast() - _s3.removeLast()));
              break;
            case "/":
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 / r1);
              break;
          }
        }
      }
      res = _s3[0];
      _output += "$res";
      _s3 = [];
      _s2 = [];
      _s1 = [];
    } //等号结束
  }
}
