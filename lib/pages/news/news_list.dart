import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/G.dart';
import '../../utils/aspect_radio_image.dart';

class NewsList extends StatefulWidget {
  final List newsList;
  NewsList({Key? key, required this.newsList}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      var item = widget.newsList[index];
      return GestureDetector(
          onTap: () {
            print(index);

            /// 跳转到课程详情页
            // print("/course_detail?id=222&title=课程标题");
            Map<String, dynamic> p = {
              'uniquekey': item['uniquekey'],
              // 'title': course['title'],
            };

            G.router
                .navigateTo(context, "/news_detail" + G.parseQuery(params: p));
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: _renderNewsItem(item),
          ));
    }, childCount: widget.newsList.length));
  }

  Widget _renderNewsItem(Map item) {
    if (item['thumbnail_pic_s02'] != '' && item['thumbnail_pic_s03'] != '') {
      return _renderThreeImages(item);
    } else {
      return _renderOneImage(item);
    }
  }

  Widget _renderOneImage(Map item) {
    return Flex(direction: Axis.horizontal, children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(item['thumbnail_pic_s'],
              fit: BoxFit.cover, height: 160.h, width: 220.w)),
      Expanded(
        // flex: 3,
        child: Container(
            height: 160.h,
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
                        item['author_name'],
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      )),
                  Row(
                    children: [
                      Container(
                        child: Text('@ ' + item['date'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),
                ])),
      ),
    ]);
  }

  Widget _renderThreeImages(Map item) {
    return Column(
        // direction: Axis.vertical,
        children: [
          Container(
              height: 30,
              width: double.infinity,
              child: Text(
                item['title'],
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              )),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ItemFitWidthNetImage(
                    item['thumbnail_pic_s'],
                    // fit: BoxFit.cover,
                    // height: 160.h,
                    (750.w - 100) / 3,
                  )),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ItemFitWidthNetImage(
                    item['thumbnail_pic_s02'],
                    // fit: BoxFit.cover,
                    // height: 160.h,
                    (750.w - 100) / 3,
                  )),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ItemFitWidthNetImage(
                    item['thumbnail_pic_s03'],
                    // fit: BoxFit.cover,
                    // height: 160.h,
                    (750.w - 100) / 3,
                  ))
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('@ ' + item['date'].toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  )),
              Text(
                item['author_name'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          )
        ]);
  }

  // ignore: non_constant_identifier_names
  Widget ItemFitWidthNetImage(String url, double fitWidth) {
    return AspectRadioImage.network(url, builder: (context, snapshot, url) {
      //计算缩放
      double scale = snapshot.data!.width.toDouble() / fitWidth;
      double fitHeight = snapshot.data!.height.toDouble() / scale;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: fitWidth,
            height: fitHeight,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
            ),
          )
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
