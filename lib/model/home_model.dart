
import 'config_model.dart';
import 'common_model.dart';
import 'grid_nav_model.dart';
import 'sales_box_model.dart';

class HomeModel{
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  // HomeModel({required this.config,required this.bannerList,required this.localNavList,required this.gridNav,required this.subNavList,required this.salesBox});

  HomeModel(this.config, this.bannerList, this.localNavList, this.gridNav,
      this.subNavList, this.salesBox);

  factory HomeModel.fromJson(Map <String,dynamic> json){

    var localNavListJson = json["localNavList"] as List;
    List <CommonModel>  localNavList = localNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    var bannerListJson = json["bannerList"] as List;
    List <CommonModel>  bannerList = bannerListJson.map((e) => CommonModel.fromJson(e)).toList();

    var subNavListJson = json["subNavList"] as List;
    List <CommonModel>  subNavList = subNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    ConfigModel config =  ConfigModel.fromJson(json["config"]);
    GridNavModel gridNav =  GridNavModel.fromJson(json["gridNav"]);
    SalesBoxModel salesBox =  SalesBoxModel.fromJson(json["salesBox"]);

    return HomeModel(config, bannerList, localNavList, gridNav, subNavList, salesBox);

  }
}