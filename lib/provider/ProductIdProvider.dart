import 'package:flutter/foundation.dart';

class ProductIdProvider with ChangeNotifier {
  int _productId = 0;

  int get productId => _productId;

  void setId(int id) {
    _productId = id;
    notifyListeners();
  }
}
