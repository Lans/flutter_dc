import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dc/bean/web_bean.dart';

class WebsProvider with ChangeNotifier {
  Stream<WebBean> _webBeanStream;

  Stream<WebBean> get webBeanStream => _webBeanStream;
}
