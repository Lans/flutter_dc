import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dc/bean/home_bean.dart';
import 'package:flutter_dc/provider/HomeProvider.dart';
import 'package:provider/provider.dart';

import 'http/ApiUrl.dart';
import 'provider/ProductIdProvider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Future<HomeBean> homeBeanFuture;

  @override
  void initState() {
    super.initState();
    homeBeanFuture = getHomeData();
  }

  Future<HomeBean> getHomeData() async {
    HomeBean homeBean;
    await ApiUrl.instance.homeHttp().then((res) {
      homeBean = HomeBean.fromJson(res.data);
    });
    return homeBean;
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final productIdProvider = Provider.of<ProductIdProvider>(context);
    homeProvider.transformerData(homeBeanFuture);
    return FutureBuilder<HomeBean>(
        future: homeBeanFuture,
        builder: (BuildContext context, AsyncSnapshot<HomeBean> snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: AutoSizeText("请求失败"),
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
                          AutoSizeText(
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
                                            AutoSizeText(
                                              product.name,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            AutoSizeText(
                                              "${product.borrowingBalanceMin}~${product.borrowingBalanceMax}元",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15,
                                              ),
                                            ),
                                            AutoSizeText(
                                                "${product.applyNums}人申请",
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
                                        child: AutoSizeText(
                                          "立即申请",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60)),
                                        onPressed: () {
                                          productIdProvider
                                              .setId(product.productId);
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
              return AutoSizeText("none");
            case ConnectionState.active:
              break;
          }
          return AutoSizeText("empty");
        });
  }
}
