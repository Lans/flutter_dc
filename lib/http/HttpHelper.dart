import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

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

  HttpHelper() {
    //基本设置
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: getBaseUrl(),
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    dio = Dio(baseOptions);
    //拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
      Map<String, dynamic> map = requestOptions.data;
      if (map == null) {
        map = Map<String, dynamic>();
        map['admin_id'] = 6;
        map['time_stamp'] = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      } else {
        map['admin_id'] = 6;
        map['time_stamp'] = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      }
      List<String> keys = map.keys.toList();
      // key排序
      keys.sort((a, b) {
        List<int> al = a.codeUnits;
        List<int> bl = b.codeUnits;
        for (int i = 0; i < al.length; i++) {
          if (bl.length <= i) return 1;
          if (al[i] > bl[i]) {
            return 1;
          } else if (al[i] < bl[i]) return -1;
        }
        return 0;
      });
      String sign = "";
      keys.forEach((kk) {
        sign += (kk + map[kk].toString());
      });
      map["sign"] = md5String(sign);
      requestOptions.data = map;
      map.forEach((key, val) {
        print("key-value：$key -> $val");
      });
      return requestOptions;
    }, onResponse: (Response response) {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      // Do something with response error
      print(e.message);
      return e; //continue
    }));
    //log拦截
    dio.interceptors.add(LogInterceptor(responseBody: !inProduction));
  }

  static String md5String(String sign) {
    var content = new Utf8Encoder().convert(sign);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}
