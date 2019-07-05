import 'package:flutter/cupertino.dart';
import 'package:flutter_dc/bean/home_bean.dart';

class FindProvider extends ChangeNotifier {
  List<Product> _productList;
  Product product;

  void transformerData(HomeBean home) {
    _productList = home.data.product;
  }

  Product getProduct(int index) {
    product = _productList[index];
    return product;
  }
}
