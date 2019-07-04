import 'package:flutter/material.dart';
import 'package:flutter_dc/find.dart';
import 'package:flutter_dc/me.dart';
import 'home.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  int index = 0;

  var _textWidget = [];

  @override
  void initState() {
    super.initState();
    _textWidget = [HomePage(), FindPage(), MePage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _textWidget[index]),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), title: Text("发现")),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("我的"))
        ],
        currentIndex: index,
        onTap: _onItemTaped,
      ),
    );
  }

  void _onItemTaped(int value) {
    setState(() {
      index = value;
    });
  }
}
