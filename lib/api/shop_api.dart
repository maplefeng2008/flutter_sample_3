// ShopAPI.dart
import 'package:dio/dio.dart';

class ShopAPI {
  final Dio _dio;

  ShopAPI(this._dio);

  /// 门店详情
  Future<dynamic> detail(String id) async {
    Response res = await _dio.get('/shop/detail',
      queryParameters: {
        'id': id,
      });

    return res.data;
  }
}