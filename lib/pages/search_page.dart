import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("下拉刷新"),
      ),
      body:LiquidPullToRefresh(

        onRefresh: () async {
          //模拟网络请求
          await Future.delayed(Duration(milliseconds: 2000));
          //结束刷新
          return Future.value(true);
        },
        //一个列表
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 66,
              child: Text("测试数据"),
            );
          },
          //列表数据源数量
          itemCount: 100,
        ),
      ),
    );
  }
}
