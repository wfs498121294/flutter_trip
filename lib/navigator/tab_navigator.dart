import 'package:flutter/material.dart';
import 'package:flutter_trip_study/pages/home_page.dart';
import 'package:flutter_trip_study/pages/mine_page.dart';
import 'package:flutter_trip_study/pages/search_page.dart';
import 'package:flutter_trip_study/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  final PageController _controller = PageController(
    initialPage: 0
  );
  
  //页面
  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const TravelPage(),
    const MinePage()
  ];

  // 这里无法访问属性
  final defaultColor = Colors.grey;
  final activeColor = Colors.blue;
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          _controller.jumpToPage(index);
          setState(() {
            currentIndex = index;
          });
        },
        items:  [
           BottomNavigationBarItem(
               icon: Icon(Icons.home,color:defaultColor),
               activeIcon:Icon(Icons.home,color: activeColor),
               label: "首页"
           ),
           BottomNavigationBarItem(icon: Icon(Icons.search,color: defaultColor),activeIcon:Icon(Icons.search,color: activeColor) ,label: "搜索"),
           BottomNavigationBarItem(icon: Icon(Icons.photo_camera,color: defaultColor),activeIcon:Icon(Icons.flight,color: activeColor) ,label: "旅拍"),
           BottomNavigationBarItem(icon: Icon(Icons.account_circle,color: defaultColor),activeIcon:Icon(Icons.account_circle,color: activeColor) ,label: "我的")
        ],
      ),
    );
  }
}
