import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dc/http/HttpHelper.dart';

class ApiUrl {
  String _login = "/user/login";
  String _home = "/home/index";
  String _borrow = "/borrow/index";
  String _url = "/borrow/product_url";
  int p = Platform.isAndroid ? 1 : 2;
  Map<String, dynamic> _map;
  HttpHelper httpHelper = HttpHelper();

  factory ApiUrl() => _getInstance();

  static ApiUrl get instance => _getInstance();
  static ApiUrl _instance;

  ApiUrl._internal() {
    // 初始化
  }

  static ApiUrl _getInstance() {
    if (_instance == null) {
      _instance = ApiUrl._internal();
    }
    return _instance;
  }

  Future<Response> loginHttp(
    String phone,
    String code,
    String ver,
    String phoneModel,
    String deviceId,
  ) async {
    _map = Map();
    _map["phone"] = phone;
    _map["code"] = code;
    _map["ver"] = ver;
    _map["phone_model"] = phoneModel;
    _map["device_id"] = deviceId;
    _map["platform"] = p;
    return await httpHelper.dio.post(_login, data: _map);
  }

  Future<Response> homeHttp() async {
    _map = Map();
    return await httpHelper.dio.post(_home, data: _map);
  }

  Future<Response> webHttp(int id, String userId) async {
    _map = Map();
    _map['product_id'] = id;
    _map['user_id'] = userId;
    return await httpHelper.dio.post(_url, data: _map);
  }
}
