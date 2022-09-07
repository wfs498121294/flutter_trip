import 'common_model.dart';

class GridNavModel{
   GridNavItem? hotel;
   GridNavItem? flight;
   GridNavItem? travel;

  GridNavModel({
    required this.hotel,
    required this.flight,
    required this.travel
  });

  factory GridNavModel.fromJson(Map<String,dynamic> json){

    return GridNavModel(
      hotel: GridNavItem.fromJson(json["hotel"]),
      flight: GridNavItem.fromJson(json["flight"]),
      travel: GridNavItem.fromJson(json["travel"])
    );
  }
}

class GridNavItem{
  late final String startColor;
  late final String endColor;
  late final CommonModel mainItem;
  late final CommonModel item1;
  late final CommonModel item2;
  late final CommonModel item3;
  late final CommonModel item4;

  GridNavItem({
    required this.startColor,
    required this.endColor,
    required this.mainItem,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4
  });

  factory GridNavItem.fromJson(Map<String,dynamic> json){
    return GridNavItem(
        startColor:json["startColor"],
        endColor: json["endColor"],
        mainItem:CommonModel.fromJson(json["mainItem"]),
        item1:CommonModel.fromJson(json["item1"]),
        item2:CommonModel.fromJson(json["item2"]),
        item3:CommonModel.fromJson(json["item3"]),
        item4:CommonModel.fromJson(json["item4"])
    );
  }
}