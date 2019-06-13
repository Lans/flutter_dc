import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {
  //final img = 
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551959224096&di=11b249528c11a76dcd321d919af14b30&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171215%2F715dd4682c6c491f90380d10fa1fced0.jpeg",
      fit:BoxFit.fill,);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
     Navigator.of(context).pushReplacementNamed('/mainPage');
    });
  }
}
