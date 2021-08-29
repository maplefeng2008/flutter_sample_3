import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:necproject/routes/routes.dart';
import 'package:necproject/utils/custom/custom_localizations.dart';
import 'package:necproject/utils/g.dart';

import 'package:provider/provider.dart';
import 'package:necproject/providers/user_provider.dart';
import 'package:necproject/providers/product_provider.dart';

import 'pages/index_page.dart';
// import 'package:necproject/pages/index_page.dart';

void main() {
  Routes.configureRoutes(G.router); // 初始化全局中的 router

  runApp(
    // 使用 Provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
    // const MyApp()
  );
  
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334), 
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: G.navigatorKey, // 声明全局 key，然后才能获取全局上下文
        home: IndexPage(),
        builder: EasyLoading.init(),
        localizationsDelegates: [
          // 本地化的代理类
          CustomLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,  // Material 国际化
          GlobalCupertinoLocalizations.delegate, // Cupertino 国际化
          GlobalWidgetsLocalizations.delegate,   // Widgets 国际化
        ],
        supportedLocales: [
          const Locale('en', 'US'), // 美国英语
          const Locale('zh', 'CN'), // 中文简体
        ]
      ),
    );
    
    
  }
}
