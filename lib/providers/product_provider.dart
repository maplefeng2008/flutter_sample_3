import 'package:flutter/material.dart';

// 商品状态管理
class ProductProvider with ChangeNotifier {
  int _skuNum = 1;
  bool _single = true;
  
  int get skuNum => _skuNum;
  bool get single => _single;
  
  // 递增
  void increment() {
    _skuNum++;

    // @todo 执行后台接口
    notifyListeners();
  }

  // 递减
  void decrement() {
    if (_skuNum > 1) {
      _skuNum--;

      // @todo 执行后台接口
      notifyListeners();
    }
  }
}