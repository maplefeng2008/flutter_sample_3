import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:math';

import '../../utils/G.dart';

import 'news_list.dart';

class News extends StatefulWidget {
  News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  List newsList = [];
  List types = [
    { 'key': 'top', 'title': '头条'},
    { 'key': 'shehui', 'title': '社会'},
    { 'key': 'guonei', 'title': '国内'},
    { 'key': 'guoji', 'title': '国际'},
    { 'key': 'yule', 'title': '娱乐'},
    { 'key': 'tiyu', 'title': '体育'},
    { 'key': 'junshi', 'title':  '军事'},
    { 'key': 'keji', 'title': '科技'},
    { 'key': 'caijing', 'title': '财经'},
    { 'key': 'shishang', 'title': '时尚'},
    { 'key': 'youxi', 'title': '游戏'},
    { 'key': 'qiche', 'title': '汽车'},
    { 'key': 'jiankang', 'title': '健康'}
  ];
  String type = 'top';
  int currentIndex = 0;
  int page = 1;
  bool loaded = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    _initData();
  }

  // 刷新
  void _onRefresh() async {
    _loadData(true);
  }

  // 加载下一页
  void _onLoading() async {
    _loadData(false);
  }

  // 初始化数据
  void _initData() async {
    _loadData(true);
  }

  _loadData(final bool onRefresh) async {
    if (onRefresh) {
      page = 1;
    } else {
      page++;
    }

    var res = await G.api.news.getList(type: type, page: page);

    // if (page == res.pages) {
    //   // 如果所有数据已经加载完毕，则不能再刷新列表
    //   _enablePullUp = false;
    // }

    // 如果有数据，则展示
    if (res['data'].length > 0) {
      
      if (onRefresh) {
        loaded = true;
        newsList = [];
        newsList = res['data'];
        _refreshController.refreshCompleted();
      } else {
        newsList.addAll(res['data']);
        if (mounted) setState(() {});
        _refreshController.loadComplete();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _renderFreshList();
  }

  Widget _renderType(int i) {
    Color pColor = Theme.of(context).primaryColor; // 字体颜色
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        decoration: BoxDecoration(
          color: currentIndex == i ? Colors.blue.shade100 : Colors.grey.shade100,
          border: Border(
            bottom: BorderSide(
                width: 3,
                color: currentIndex == i ? Colors.blue.shade200 : Colors.grey.shade100),
          ),
        ),
        child: Text(
          types[i]['title'],
          style: TextStyle(
            color: currentIndex == i ? pColor : Colors.black45,
            fontWeight: currentIndex == i ? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      onTap: () {
        currentIndex = i; //记录选中的下标
        type = types[i]['key'];
        pColor = Colors.blue;

        _initData();

        Future.delayed(Duration(milliseconds: 500), () { 
          setState(() {
            // 标记更新
          });
        });
      },
    );
  }

  Widget _renderFreshList() {
    return SmartRefresher(
      // enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      // footer: ClassicFooter(),
      footer: _renderCustomFooter(),
      controller: _refreshController,
      onRefresh: _onRefresh, // 第一次加载
      onLoading: _onLoading, // 加载更多
      child: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter(
          //   child: Container(
          //     height: 50,
          //     color: Colors.grey.shade100,
          //     child: ListView.builder(
          //       itemCount: types.length,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (BuildContext context, int index) {
          //         return _renderType(index);
          //       },
          //     ),
          //   ),
          // ),
          // 带有吸顶效果的 header
          SliverPersistentHeader(
            pinned: true, // 是否固定
            floating: false, // 是否浮动 默认false
            // 必传参数,头布局内容
            delegate: MySliverDelegate(
              minHeight: 50.0, // 缩小后的布局高度
              maxHeight: 50.0, // 展开后的高度
              child: Container(
                height: 50,
                color: Colors.grey.shade100,
                child: ListView.builder(
                  itemCount: types.length,
                  scrollDirection: Axis.horizontal, // 水平方向滚动
                  itemBuilder: (BuildContext context, int index) {
                    return _renderType(index);
                  },
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(5),
            sliver: NewsList(newsList: newsList),
          )
        ]
      ),
      
    );
  }

  Widget _renderCustomFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode){
        Widget body;
        if (mode == LoadStatus.idle) {
          body =  Text("上拉刷新");
        } else if (mode == LoadStatus.loading) {
          body =  CircularProgressIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("加载失败，请重试");
        } else if (mode == LoadStatus.canLoading) {
            body = Text("可以加载更多");
        } else {
          body = Text("没有数据");
        }
        return Container(
          height: 50.0,
          child: Center(
            child: body
          ),
        );
      },
    );
  }
}

class MySliverDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget child; //子Widget布局

  MySliverDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override //是否需要重建
  bool shouldRebuild(MySliverDelegate oldDelegate) {
    return true;
  }
}