import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../../utils/g.dart';

class HomeSwiper extends StatefulWidget {
  HomeSwiper({Key? key}) : super(key: key);

  @override
  _HomeSwiperState createState() => _HomeSwiperState();
}

class _HomeSwiperState extends State<HomeSwiper> {
  List slide = [
    // {
    //   "id": "220000199901226210",
    //   "title": "先区想或情时同青酸些记取维同由",
    //   "image": "http://dummyimage.com/360X160/79f29a"
    // },
    // {
    //   "id": "650000200808081921",
    //   "title": "保叫十自专条该接特改热形级",
    //   "image": "http://dummyimage.com/360X160/f2797b"
    // },
    // {
    //   "id": "510000198309201713",
    //   "title": "术半深张究低断身张适张有",
    //   "image": "http://dummyimage.com/360X160/799ef2"
    // },
    // {
    //   "id": "500000197701209238",
    //   "title": "近率志传的油",
    //   "image": "http://dummyimage.com/360X160/c1f279"
    // },
    // {
    //   "id": "710000200906139986",
    //   "title": "一少连把六或政山府者表深素说",
    //   "image": "http://dummyimage.com/360X160/f279e5"
    // }
  ];

  var _futureSaved;

  @override
  void initState() {
    super.initState();

    // 调用接口
    // G.api.home.getSlide().then((value) {
    //   print(value);
    //   slide = value['data']['list'];
    // });

    _futureSaved = G.api.home.getSlide();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: Future.delayed(Duration(seconds: 3), () async {
      //   return await G.api.course.courseDetail(id: widget.id);
      // }),
      future: _futureSaved, // 接口调用
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
            // case ConnectionState.none: // 初始态
            //   return ElevatedButton(
            //     onPressed: () {}, 
            //     child: Text('点击发送请求i')
            //   );
            //   break;
          case ConnectionState.waiting: // 正在等待
            return Center(
              child: CircularProgressIndicator()
            );
          case ConnectionState.done: // 加载完成
            if (snapshot.hasError) { // 对报错进行处理
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: TextStyle(color: Colors.red)
                )
              );
            } else if (snapshot.hasData) { // 成功获取数据
              print('轮播图 异步请求成功');
              // var course = snapshot.data;
              var apidata = snapshot.data as Map;
              slide = apidata['data']['list'];

              // 展示
              return Container(
                height: 200,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      slide[index]['image'],
                      fit: BoxFit.fill,
                    );
                  },
                  indicatorLayout: PageIndicatorLayout.SCALE,
                  autoplay: true,
                  autoplayDelay: 3000,
                  itemCount: slide.length,
                  pagination: new SwiperPagination(),
                  // control: new SwiperControl(),
                  fade: 1.0,
                  viewportFraction: 1,
                )
              );
            } else {
              return Center(
                child: CircularProgressIndicator()
              );
            }
          default:
            return Container();
        }
      }
    );
  }
}