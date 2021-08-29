import 'package:dio/dio.dart';

import 'init_dio.dart';
import 'home_api.dart';
import 'user_api.dart';
import 'shop_api.dart';
import 'news_api.dart';

class API {
  Dio _dio = initDio();

  API() {
    // _dio = initDio();
  }

  /// 首页接口 
  /// G.api.home.getSlide()
  /// api.home.shopList()
  HomeAPI get home => HomeAPI(_dio);

  /// 门店接口
  ShopAPI get shop => ShopAPI(_dio);

  /// 用户接口
  /// api.user.login()
  /// api.user.register()
  UserAPI get user => UserAPI(_dio);

  /// 新闻接口
  NewsAPI get news => NewsAPI(_dio);
}