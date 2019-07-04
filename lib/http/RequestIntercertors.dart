import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class RequestInterceptor extends Interceptor {
  static String md5String(String sign) {
    var content = new Utf8Encoder().convert(sign);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  @override
  onRequest(RequestOptions options) {
    Map<String, dynamic> map = options.data;
    if (map == null) {
      map = Map<String, dynamic>();
    }
    map['admin_id'] = 6;
    map['time_stamp'] = DateTime.now().millisecondsSinceEpoch ~/ 1000;
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
    options.data = map;
    map.forEach((key, val) {
      print("key-value：$key -> $val");
    });

    return super.onRequest(options);
  }
}
