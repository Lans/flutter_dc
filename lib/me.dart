import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dc/setting.dart';

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
                      Text(
                        "我的",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          number,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
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
                if (index == list.length-1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingPage()),
                  );
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
                            Text(
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