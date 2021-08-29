import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../pages/unknown/unknown_page.dart';
import '../pages/index_page.dart';
import '../pages/shop/shop.dart';
import '../pages/mine/login.dart';
import '../pages/mine/address.dart';

// 空页面
var unknownHandler = new Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return UnknownPage();
  }
);

// 默认页
var indexHandler = new Handler(
  handlerFunc: (BuildContext? context, Map<String, List<Object>> params) {
    return IndexPage();
  }
);

// 个人中心页面
var mineHandler = new Handler(
  handlerFunc: (BuildContext? context, Map<String, List<Object>> params) {
    // return Mine(); // 直接跳转，没有 appBar

    // 跳转到 tab 中的一个页面
    return IndexPage(currentIndex: 3);
  }
);

// 门店详情页面
var shopDetailHandler = new Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return Shop(id: params['id']!.first);
  }
);

// 登录页
var loginHandler = new Handler(
  handlerFunc: (BuildContext? context, Map<String, List<Object>> params) {
    return Login();
  }
);

// 收货地址页
var addressHandler = new Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    return Address();
  }
);