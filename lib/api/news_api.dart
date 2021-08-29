import 'package:dio/dio.dart';

class NewsAPI {
  final Dio _dio;
  // 模拟接口无效，聚合 API 有效
  final String key = "6d7ee8d88bd4fb137f5d20ce7066a700";

  NewsAPI(this._dio);

  /// 列表
  // ignore: non_constant_identifier_names
  Future<dynamic> getList({String type = 'top', page = 1, page_size = 3}) async {
    Response res = await _dio.get('/toutiao/index',
      queryParameters: {
        'type': type,
        'page': page,
        'page_size': page_size,
        'key': key
      }
    );
    print(res.data);
    return res.data['result'];
  }

  /// 详情
  Future<dynamic> getDetail({required String uniquekey}) async {
    Response res = await _dio.get('/toutiao/content',
      queryParameters: {
        'uniquekey': uniquekey,
        'key': key
      }
    );

    return res.data['result'];
  }

  /// 分类
  Future<dynamic> getCategory() async {
    Response res = await _dio.get('/category');

    List target = res.data['data'];
    return target;
  }
}