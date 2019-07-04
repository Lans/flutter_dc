import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dc/bean/home_bean.dart';
import 'package:flutter_dc/http/ApiUrl.dart';

class HomeProvider with ChangeNotifier {
  Stream<HomeBean> _homeBeanSteam;

  int _productId;

  int get productId => _productId;

  Stream<HomeBean> get homeBeanSteam => _homeBeanSteam;

  List<Product> _productList = [];

  List<Product> get productList => _productList;

  List<String> _strList = [
    "134****3341已获得2000元",
    "154****8451已获得2000元",
    "139****6741已获得2000元",
    "184****4241已获得2000元",
  ];

  List<String> get strList => _strList;

  void getHome() {
    _homeBeanSteam = ApiUrl.instance.homeHttp().asStream().map((res) {
      HomeBean homeBean = HomeBean.fromJson(res.data);
      productList.clear();
      productList.addAll(homeBean.data.product);
    });
  }

  int getId(int index) {
    _productId = _productList[index].productId;
    notifyListeners();
    return _productId;
  }
}
