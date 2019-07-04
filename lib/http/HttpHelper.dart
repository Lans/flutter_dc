import 'package:dio/dio.dart';

import 'RequestIntercertors.dart';

class HttpHelper {
  //true 正式环境
  static const bool inProduction =
      const bool.fromEnvironment("dart.vm.product");
  String baseUrl = getBaseUrl();

  //地址切换
  static String getBaseUrl() {
    if (inProduction) {
      return "http://39.105.29.53/api";
    } else {
      return "http://test.putitt.cn/api";
    }
  }

  Dio dio;

  //基本设置
  final BaseOptions baseOptions = BaseOptions(
    baseUrl: getBaseUrl(),
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );

  HttpHelper() {
    dio = Dio(baseOptions);
//    var defaultHttpClientAdapter = new DefaultHttpClientAdapter();
//    defaultHttpClientAdapter.onHttpClientCreate = (HttpClient h) {
//      h.findProxy = (uri) {
//        return "PROXY 192.168.232.241:8888";
//      };
//    };
//    dio.httpClientAdapter = defaultHttpClientAdapter;
    dio.interceptors.add(RequestInterceptor());
    //log拦截
    dio.interceptors.add(LogInterceptor(responseBody: !inProduction));
  }
}
