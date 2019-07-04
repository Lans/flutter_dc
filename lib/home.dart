import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dc/bean/home_bean.dart';
import 'package:flutter_dc/provider/HomeProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    homeProvider.getHome();
    return StreamBuilder<HomeBean>(
        stream: homeProvider.homeBeanSteam,
        builder: (BuildContext context, AsyncSnapshot<HomeBean> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text("请求失败"),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                      child: Column(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image.asset("asset/black_bg.png"),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
                          child: Image.asset("asset/banner.png"),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "asset/message.png",
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
                            "asset/top_img.png",
                            width: 100,
                            height: 20,
                          ),
                        ))
                  ])),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    final product = homeProvider.productList[index];
                    return AnimatedContainer(
                        duration: Duration(seconds: 1),
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
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
                                    Image.network(
                                      product.pic,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "${product.borrowingBalanceMin}~${product.borrowingBalanceMax}元",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text("${product.applyNums}人申请",
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                      ),
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
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        onPressed: () {
                                          homeProvider.getId(index);
                                          Navigator.pushNamed(context, "/web");
                                        }),
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
                  }, childCount: homeProvider.productList.length)),
                ],
              );
            case ConnectionState.none:
              return Text("none");
            case ConnectionState.active:
              break;
          }
          return Text("empty");
        });
  }
}
