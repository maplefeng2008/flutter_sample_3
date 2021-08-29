import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/g.dart';

class Category extends StatefulWidget {
  Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 200,
            width: G.w() / 3,
          ),
        ]
      ),
    );
  }
}