import 'package:flutter/material.dart';
import 'package:flutter_trip_study/widgets/webview1.dart';
import '../model/common_model.dart';

class SubNav extends StatelessWidget {
   List<CommonModel>? subNavList;
   SubNav({Key? key,required this.subNavList}) : super(key: key);


  Widget _item(BuildContext context,CommonModel model){
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              WebViewPage(url: model.url ?? "",statusBarColor: model.statusBarColor ?? "faff",hideAppBar: model.hideAppBar ?? false, backForbid: false, title: model.title ?? "")
          )
          );
        },
        child: Column(
          children: [
            Image.network(model.icon,width: 18,height: 18,),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(model.title ?? "",style: const TextStyle(fontSize: 12,color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  _items(BuildContext context){
    if(subNavList == null){
       return null;
    }
    List <Widget> items = [];
    int separate = ((subNavList?.length ?? 0)/2 + 0.5).toInt();

    for(CommonModel model in subNavList!){
      items.add(_item(context, model));
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0,separate),
        ),
        Padding(
            padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate,subNavList?.length),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      )
    );
  }
}
