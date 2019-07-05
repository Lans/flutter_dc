import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dc/bean/home_bean.dart';

class HomeProvider with ChangeNotifier {
  List<Product> _productList = [];

  List<Product> get productList => _productList;

  List<String> _strList = [
    "134****3341已获得2000元",
    "154****8451已获得2000元",
    "139****6741已获得2000元",
    "184****4241已获得2000元",
  ];

  List<String> get strList => _strList;

  void transformerData(Future<HomeBean> homeBeanFuture) {
    homeBeanFuture.then((res) {
      productList.clear();
      productList.addAll(res.data.product);
    });
  }
}
