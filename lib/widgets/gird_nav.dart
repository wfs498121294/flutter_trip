
import 'package:flutter/material.dart';
import 'package:flutter_trip_study/model/common_model.dart';
import 'package:flutter_trip_study/model/grid_nav_model.dart';
import 'package:flutter_trip_study/widgets/webview1.dart';

class GridNav extends StatelessWidget {
   GridNavModel? gridNavModel;
   GridNav({Key? key,required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _girdItem(context),
      ),
    );
  }

  _girdItem(BuildContext context){
     List<Widget> items = [];
     if(gridNavModel == null){
       return items;
     }

     if(gridNavModel?.flight != null){
       items.add(_girdNavItem(context, (gridNavModel?.flight)!, true));
     }
     if(gridNavModel?.hotel != null){
       items.add(_girdNavItem(context, (gridNavModel?.hotel)!, false));
     }

     if(gridNavModel?.travel != null){
       items.add(_girdNavItem(context, (gridNavModel?.travel)!, false));
     }

     return items;
  }

  _girdNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1,  gridNavItem.item2, true));
    items.add(_doubleItem(context, gridNavItem.item3,  gridNavItem.item4, true));

    List <Widget> expandedItems = [];

    items.forEach((item) {
      expandedItems.add(Expanded(child: item,flex: 1));
    });


    Color startColor = Color(int.parse("0xff"+gridNavItem.startColor));
    Color endColor = Color(int.parse("0xff"+gridNavItem.endColor));

    return Container(
      height: 88,
      margin: first?null:const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor,endColor]),
      ),
      child: Row(children: expandedItems),
    );
  }

  //最左边的item
  _mainItem(BuildContext context, CommonModel model){

    print(model);
    return _wrapGesture(context, Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.network(model.icon ?? "",fit: BoxFit.contain,height: 88,width: 120,alignment: AlignmentDirectional.bottomEnd,),
        Text(model.title ?? "",style: const TextStyle(fontSize: 14,color: Colors.white))
      ],
    ), model);
  }

  _doubleItem(BuildContext context,CommonModel topModel,CommonModel bottomModel, bool isCenterItem){
    return Column(
      children: [
        // Expanded 与 FractionallySizedBox 区别 https://www.jianshu.com/p/0f6a17eaafcf
        Expanded(child: _item(context, topModel, true, isCenterItem)),// Expanded常用于Row, Column, Flex的子元素中；在使用Expanded子Widget的时候，能够填充满剩余空间。
        Expanded(child: _item(context, bottomModel, false, isCenterItem))
      ],
    );
  }

  _item(BuildContext context,CommonModel model, bool first,bool isCenterItem){
    BorderSide borderSide = const BorderSide(width: 0.8,color: Colors.white);
    return  FractionallySizedBox(
       widthFactor: 1,// 撑满父类的宽度
      child: Container(
      decoration: BoxDecoration(
        border: Border(left: borderSide,bottom: first ?borderSide:BorderSide.none),
      ),
        child: _wrapGesture(context, Center(
          child: Text(model.title ?? "",textAlign: TextAlign.center,style: const TextStyle(fontSize: 14,color: Colors.white),),
        ), model)
      ),
    );
  }

  _wrapGesture(BuildContext context,Widget widget, CommonModel model){
    return GestureDetector(
      onTap: (){
        print(model.url ?? "");
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            WebViewPage(url: model.url ?? "",statusBarColor: model.statusBarColor ?? "faff",hideAppBar: model.hideAppBar ?? false, backForbid: false, title: model.title ?? "")
        )
        );
      },
      child: widget,
    );
  }

}
