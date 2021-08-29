import 'package:fluro/fluro.dart';
import 'routes_handler.dart';

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.define('/', handler: indexHandler);
    router.define('/mine', handler: mineHandler);
    router.define('/shop', handler: shopDetailHandler);
    router.define('/login', handler: loginHandler);
    router.define('/address', handler: addressHandler);

    router.notFoundHandler = unknownHandler; // 未知页面
  }
}
