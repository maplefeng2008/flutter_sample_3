import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:necproject/utils/custom/custom_localizations.dart';

import '../api/api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class G {
  /// 初始化 API
  /// G.api.home.getSlide()
  /// G.api.user.login()
  static final API api = API();

  static w() {
    return 750.w;
  }

  static h() {
    return 1334.h;
  }

  static success(msg) {
    EasyLoading.showSuccess(msg);
  }

  static error(msg) {
    EasyLoading.showError(msg);
  }

  static info(msg) {
    EasyLoading.showInfo(msg);
  }

  static toast(msg) {
    EasyLoading.showToast(msg);
  }

  /// Fluro路由
  // static FluroRouter router = FluroRouter();
  static FluroRouter router = FluroRouter.appRouter;

  /// 将请求参数，由 Map 解析成 query
  static parseQuery({required Map<String, dynamic> params}) {
    String query =  "";
    int index = 0;
    for (String key in params.keys) {
      final String value = Uri.encodeComponent(params[key].toString());
      if (index == 0) {
        query = "?";
      } else {
        query = query + "\&";
      }
      query += "$key=$value";
      index++;
    }
    return query.toString();
  }

    /// 导航唯一key
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  /// 获取构建上下文
  static BuildContext getCurrentContext() => navigatorKey.currentContext!;


  // static t(String key) {
  //   CustomLocalizations.of(getCurrentContext()).t(key);
  // }
  static String t(String key) {
    return CustomLocalizations.of(getCurrentContext()).t(key);
  }

}