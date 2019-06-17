import 'package:flutter/material.dart';
import 'dart:ui';

class HomePge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: MainLayout(),
    );
  }
}

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverToBoxAdapter(
          child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset("assetImg/black_bg.png"),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
              child: Image.asset("assetImg/banner.png"),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 5, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assetImg/message.png",
                width: 100,
                height: 20,
              ),
              Text(
                "1321xxxx123以获取1000元",
                style: TextStyle(color: Colors.black54),
              )
            ],
          ),
        ),
        Container(
            width: window.physicalSize.width,
            margin: EdgeInsets.only(left: 10, right: 10),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Image.asset(
                "assetImg/top_img.png",
                width: 100,
                height: 20,
              ),
            ))
      ])),
      ListLayout()
    ]);
  }
}

class ListLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}

class ListState extends State<ListLayout> {
  List names = [];

  @override
  void initState() {
    super.initState();
    createData();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          color: Colors.white,
          child: InkWell(
            onTap: () {
              ///todo 点击事件
              print("the is the item of $index");
              final snackBar = SnackBar(
                content: Text("the is the item of $index"),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                    label: "取消",
                    onPressed: () {
                      Scaffold.of(context).hideCurrentSnackBar(
                          reason: SnackBarClosedReason.dismiss);
                    }),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assetImg/ic_launcher.png",
                        width: 50,
                        height: 50,
                      ),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  names[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                Text("1000~10000",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                    )),
                                Text("100人申请",
                                    style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 12,
                                    )),
                              ],
                            )),
                      ),
                      MaterialButton(
                          textColor: Colors.white,
                          color: Color.fromRGBO(21, 201, 187, 1),
                          height: 30,
                          child: Text(
                            "立即申请",
                            style: TextStyle(fontSize: 13),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60)),
                          onPressed: () {}),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60, 0, 5, 0),
                  child: Divider(
                    height: 1.0,
                  ),
                )
              ],
            ),
          ));
    }, childCount: names.length));
  }

  void createData() {
    for (int i = 0; i < 7; i++) {
      names.add("我是名字$i");
    }
  }
}
