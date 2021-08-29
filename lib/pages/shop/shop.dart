import 'package:flutter/material.dart';
import 'package:necproject/utils/g.dart';

class Shop extends StatefulWidget {
  final String id;
  Shop({Key? key, required this.id}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  Map detail = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                G.router.navigateTo(context, '/');
              },
              child: Icon(Icons.home)),
          SizedBox(width: 10)
        ],
      ),
      body: FutureBuilder(
        future: G.api.shop.detail(widget.id),
        builder: (context, snapshot) {
          // 返回数据成功
          if (snapshot.hasData) {
            var res = snapshot.data as Map;
            if (res['code'] == 200) {
              detail = res['data'];

              return ListView(
                // shrinkWrap: true,
                children: [
                  Text(detail['title'].toString())
                  // // 获取商品轮播图
                  // _getProductSwiper(),

                  // // 展示商品标题
                  // _getProductTitle(),

                  // // 展示商品价格
                  // _getProductPrice(),

                  // // 展示商品规格
                  // _getProductSpec(),

                  // ProductDescription(detail: detail)
                ],
              );
            } else {
              G.error('查询失败');
            }
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
