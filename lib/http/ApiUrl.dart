import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dc/http/HttpHelper.dart';

class ApiUrl {
  String login = "/user/login";
  String home = "/home/index";
  String borrow = "/borrow/index";
  String url = "/borrow/product_url";
  int p = Platform.isAndroid ? 1 : 2;
  Map<String, dynamic> map = Map();

  Future<Response> loginHttp(
    String phone,
    String code,
    String ver,
    String phoneModel,
    String deviceId,
  ) async {
    map["phone"] = phone;
    map["code"] = code;
    map["ver"] = ver;
    map["phone_model"] = phoneModel;
    map["device_id"] = deviceId;
    map["platform"] = p;
    return await HttpHelper().dio.post(login, data: map).catchError((e) {
      print(e.toString());
    });
  }
}
