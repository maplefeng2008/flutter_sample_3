import 'package:flutter/material.dart';
import 'package:necproject/utils/g.dart';

import 'home/home.dart';
import 'category/category.dart';
import 'news/news.dart';
import 'mine/mine.dart';

// ignore: must_be_immutable
class IndexPage extends StatefulWidget {
  int currentIndex = 0;
  IndexPage({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      label: G.t('home'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.green,
      icon: Icon(Icons.message),
      label: G.t('news'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.amber,
      icon: Icon(Icons.shopping_cart),
      label: G.t('cart'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.red,
      icon: Icon(Icons.person),
      label: G.t('mine'),
    ),

    // BottomNavigationBarItem(
    //   backgroundColor: Colors.blue,
    //   icon: Icon(Icons.home),
    //   label: 'home',
    // ),
    // BottomNavigationBarItem(
    //   backgroundColor: Colors.green,
    //   icon: Icon(Icons.message),
    //   label: 'news',
    // ),
    // BottomNavigationBarItem(
    //   backgroundColor: Colors.amber,
    //   icon: Icon(Icons.shopping_cart),
    //   label: 'cart',
    // ),
    // BottomNavigationBarItem(
    //   backgroundColor: Colors.red,
    //   icon: Icon(Icons.person),
    //   label: 'mine',
    // ),
  ];

  final pages = [
    Home(),
    News(),
    Category(),
    Mine(),
  ];

  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(bottomNavItems[widget.currentIndex].label.toString())),
      bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: widget.currentIndex,
          type: BottomNavigationBarType.fixed,
          // type: BottomNavigationBarType.shifting,
          onTap: (index) {
            _changePage(index);
          }),
      body: pages[widget.currentIndex],
      drawer: _renderDrawer(),
    );
  }

  Drawer _renderDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('??????Drawer'),
            accountEmail: Text('wo shi Email'),
            onDetailsPressed: () {},
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/flutter.jpg'),
            ),
            decoration: BoxDecoration(
                // ????????????
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/bg1.jpg'))),
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('??????'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(
            thickness: 2,
          ), // ?????????
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text('??????'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(
            thickness: 2,
          ), // ?????????
          ListTile(
            leading: Icon(Icons.person),
            title: Text('??????'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(
            thickness: 2,
          ), // ?????????
          ListTile(
            title: Text('ListTile2'),
            subtitle: Text(
              'ListSubtitle2',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(child: Text("2")),
            onTap: () {
              Navigator.pop(context);
            }, // ?????? Drawer
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          AboutListTile(
            icon: new CircleAvatar(child: new Text("4")),
            child: new Text("??????"),
            applicationName: "????????????",
            applicationVersion: "1.0.1",
            applicationIcon: new Image.asset(
              'images/flutter.jpg',
              width: 55.0,
              height: 55.0,
            ),
            applicationLegalese: "??????????????????",
            aboutBoxChildren: <Widget>[new Text("?????????..."), new Text("?????????...")],
          ),
          Divider(), //?????????

          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            child: Center(
              child: SizedBox(
                width: 60.0,
                height: 60.0,
                child: CircleAvatar(
                  child: Text('R'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changePage(int index) {
    if (index != widget.currentIndex) {
      setState(() {
        widget.currentIndex = index;
      });
    }
  }
}
