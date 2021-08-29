import 'package:flutter/material.dart';
import 'package:necproject/providers/product_provider.dart';
import 'package:provider/provider.dart';

import 'home_swiper.dart';
import 'home_shop.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        /// 首页轮播图
        HomeSwiper(),
        //_renderProvider(),
        HomeShop()
      ],
    );
  }

  Widget _renderProvider() {
    // 获取状态模型中的数据
    var skuNum = Provider.of<ProductProvider>(context).skuNum;

    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          ElevatedButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .decrement();
              },
              child: Text('-', style: TextStyle(fontSize: 50))),
          Text(skuNum.toString(), style: TextStyle(fontSize: 50)),
          ElevatedButton(
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .increment();
              },
              child: Text('+', style: TextStyle(fontSize: 50))),
        ],
      ),
    );
  }
}
