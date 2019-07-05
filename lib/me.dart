import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MePageState();
  }
}

class MePageState extends State<MePage> {
  final number = "12313141414";
  final list = ["", "我的征信", "我的评估", "帮助中心", "其他设置"];
  final imgList = [
    "asset/ic_my_more.png",
    "asset/me1.png",
    "asset/me2.png",
    "asset/me3.png",
    "asset/me4.png",
  ];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> _getPhone() async {
    final SharedPreferences prefs = await _prefs;
    final String num = (prefs.getString('userTel') ?? "");
    return num;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AutoSizeText(
                        "我的",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: FutureBuilder<String>(
                            future: _getPhone(),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> syn) {
                              if (syn.connectionState == ConnectionState.done) {
                                if (syn.data.toString().isNotEmpty) {
                                  return AutoSizeText(
                                    syn.data.toString(),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              }
                              return AutoSizeText(
                                "请重新登录",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              );
                            }),
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {},
                    minWidth: window.physicalSize.width,
                    color: Color.fromRGBO(21, 201, 187, 1),
                    height: 4,
                  )
                ],
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                if (index == list.length - 1) {
                  Navigator.pushNamed(context, "/setting");
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Container(
                  height: 40,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(
                                imgList[index],
                                width: 20,
                              ),
                            ),
                            AutoSizeText(
                              list[index],
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        imgList[0],
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) {
          if (index != 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Divider(
                height: 1,
                color: Colors.black12,
              ),
            );
          } else {
            return Divider(
              height: 1,
              color: Colors.transparent,
            );
          }
        },
      ),
    );
  }
}
