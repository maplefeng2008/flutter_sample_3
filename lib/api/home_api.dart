// HomeAPI.dart
import 'package:dio/dio.dart';

class HomeAPI {
  final Dio _dio;

  HomeAPI(this._dio);

  /// 轮播图列表
  Future<dynamic> getSlide() async {
    Response res = await _dio.get('/home/slide');
    print(' -- 轮播图接口被调用 -- ');

    return res.data;
  }

  /// 门店列表
  Future<dynamic> getShopList(
      {String geohash = '120.22323,36.23554',
      int page = 1,
      int limit = 10}) async {
    print(' -- 门店接口被调用 -- ');
    // Response res = await _dio.get('/shop/list');
    Response res = await _dio.get('/shop/list',
      queryParameters: {
        'geohash': geohash,
        'page': page,
        'limit': limit,
      }
    );

    return res.data;
  }
}
