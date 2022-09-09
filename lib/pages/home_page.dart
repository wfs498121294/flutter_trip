import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_trip_study/common/device.dart';
import 'package:flutter_trip_study/dao/home_dao.dart';
import 'package:flutter_trip_study/model/common_model.dart';
import 'package:flutter_trip_study/model/home_model.dart';
import 'package:flutter_trip_study/widgets/gird_nav.dart';
import 'package:flutter_trip_study/widgets/loading_container.dart';
import 'package:flutter_trip_study/widgets/local_nav.dart';
import 'package:flutter_trip_study/widgets/sales_box.dart';
import 'package:flutter_trip_study/widgets/sub_nav.dart';

import '../model/grid_nav_model.dart';
import '../model/sales_box_model.dart';
import '../widgets/webview1.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var navAlpha = 0.0;
   HomeModel? homeModel;
    bool _loading = false;
   GridNavModel? gridNavModel;
   SalesBoxModel? salesBox;
   List <CommonModel> subNavList = [];
   List <CommonModel> localNavList = [];
   List <CommonModel> bannerList = [];


  _onScroll(offset) {
    if (kDebugMode) {
      // print("偏移量->$offset");
    }
    double alpha = offset / (getAppBarHeight()+statusBarHeight);
    if(alpha <0){
      alpha = 0;
    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      navAlpha = alpha;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
  }
  Future <void> _handleRefresh() async{
    _loading = true;
    try{
      HomeModel response = await HomeDao().fetch();
      setState(() {
        homeModel = response;
        localNavList = response.localNavList;
        gridNavModel = homeModel?.gridNav;
        subNavList = response.subNavList;
        salesBox = homeModel?.salesBox;
        bannerList = response.bannerList;
        _loading = false;
      });
    }
    catch(e){
      setState(() {
        _loading = false;
      });
    }
  }

  // banner 轮播图
  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        autoplay: true,
        loop: true,
        pagination: const SwiperPagination(),
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            bannerList[index].icon,
            fit: BoxFit.cover,
          );
        },
        onTap: (index) {
          CommonModel model = bannerList[index];
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                WebViewPage(url: model.url ?? "",statusBarColor: model.statusBarColor ?? "faff",hideAppBar: model.hideAppBar ?? false, backForbid: false, title: model.title ?? "")
            )
            );
          };
        },
      ),
    );
  }

  Widget get _listView{
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
            width: hcScreenWidth(),
            height: hcFitWidth(160),
            child: _banner
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7,0,7,4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7,0,7,4),
          child: SubNav(subNavList: subNavList),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(7,0,7,4),
          child: SalesBox(salesBox: salesBox),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x00f2f2f2),
      body:LoadingContainer(
        child: Stack(
          children: [
            MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child:  LiquidPullToRefresh(
                  onRefresh:_handleRefresh,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollNotification){
                      if(scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0){
                        //监听列表滚动设置透明度
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                      return true;
                    },
                    child: _listView,
                  ),
                )
            ),
            // Opacity(
            //     opacity: navAlpha,
            //   child: Container(
            //     height: kMinInteractiveDimension+statusBarHeight,
            //     decoration: const BoxDecoration(color: Colors.white),
            //     child: Center(
            //       child: Padding(
            //         padding: EdgeInsets.only(top: statusBarHeight),
            //         child:  const Text("首页"),
            //       ),
            //     ),
            //   )
            // )
          ],
        ),
        isLoading: _loading,
      )
    );
  }
}




