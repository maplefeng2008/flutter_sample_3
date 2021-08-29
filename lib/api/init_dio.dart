import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio initDio() {
  var options = BaseOptions(
    baseUrl: 'http://rap2api.taobao.org/app/mock/255557/api/v1',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = Dio(options);

  // 添加拦截器
  dio.interceptors.add(InterceptorsWrapper(
      // 请求拦截
      onRequest: (options, handler) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    int expiresTime = prefs.getInt('expires_time') ?? 0;
    // int current_time = (DateTime.now().millisecondsSinceEpoch/1000).toInt();
    int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // print('----------------------------');
    // print(token);
    // print(expires_time);
    // print(current_time);
    if (token != '' && currentTime < expiresTime) {
      options.headers['Authorization'] = 'Bearer ' + token;
    } else {
      options.headers['Authorization'] = '';
    }

    // 请求开始之前，做一些处理
    return handler.next(options); //continue
  },
      // 响应拦截
      onResponse: (response, handler) {
    // 对响应数据进行处理
    return handler.next(response); // continue
  },
      // 报错拦截
      onError: (DioError e, handler) {
    // 对响应报错进行处理
    return handler.next(e); //continue
  }));

  // 返回 dio
  return dio;
}
