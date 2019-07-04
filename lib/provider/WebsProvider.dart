import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dc/bean/web_bean.dart';
import 'package:flutter_dc/http/ApiUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebsProvider with ChangeNotifier {
  Stream<WebBean> _webBeanStream;

  Stream<WebBean> get webBeanStream => _webBeanStream;

  void getUrl(int id) {
    var userId = "";
    SharedPreferences.getInstance().then((res) {
      userId = res.getString("userId") ?? "";
    }).whenComplete(() {
      _webBeanStream =
          ApiUrl.instance.webHttp(id, userId).asStream().map((convert) {
        return WebBean.fromJson(convert.data);
      });
    });
    notifyListeners();
  }
}
