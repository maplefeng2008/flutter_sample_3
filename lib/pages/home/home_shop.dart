import 'package:flutter/material.dart';
import '../../utils/g.dart';

class HomeShop extends StatefulWidget {
  HomeShop({Key? key}) : super(key: key);

  @override
  _HomeShopState createState() => _HomeShopState();
}

class _HomeShopState extends State<HomeShop> {
  List list = [];
  var _futureSaved;

  @override
  void initState() {
    super.initState();

    _futureSaved = G.api.home.getShopList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureSaved,
        builder: (context, snapshot) {
          // 表示数据成功返回
          if (snapshot.hasData) {
            var res = snapshot.data as Map;
            if (res['code'] == 200) {
              list = res['data']['list'];
              // print(productList);

              return Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Wrap(
                      direction: Axis.horizontal, children: _renderList()));
            } else {
              // 查询失败
              G.error(res['msg']);
            }
          } else if (snapshot.hasError) {
            // 报错了
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  List<Widget> _renderList() {
    var tempList = list.map((item) {
      return InkWell(
          onTap: () {
            Map<String, dynamic> p = {
              'id': item['id'],
            };

            G.router.navigateTo(context, "/shop" + G.parseQuery(params: p));
          },
          child: Container(
            // width: (G.w() - 30),
            margin: EdgeInsets.fromLTRB(1, 5, 1, 0),
            child: _renderItem(item),
          ));
    });

    return tempList.toList();
  }

  Widget _renderItem(Map item) {
    return Container(
      // color: Colors.white,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!,
                offset: Offset(4, 4),
                blurRadius: 10.0)
          ]),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item['logo'],
                    // w: 220.w,
                    height: 100,
                  ),
                ),
                Expanded(
                  // flex: 3,
                  child: Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  item['title'],
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  "营业时间：" +
                                      item['open'] +
                                      " - " +
                                      item['close'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.orange),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Container(
                                width: double.infinity,
                                child: Text(
                                  item['sale'].toString() +
                                      "  " +
                                      item['average'],
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                            Row(
                              children: [
                                Container(
                                  child:
                                      Text("地址：" + item['address'].toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          )),
                                ),
                              ],
                            ),
                          ])),
                ),
              ],
            ),
          )),
    );
  }
}
