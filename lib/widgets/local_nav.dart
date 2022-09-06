

import 'package:flutter/material.dart';
import 'package:flutter_trip_study/model/common_model.dart';
import 'package:flutter_trip_study/widgets/webview.dart';
import 'package:flutter_trip_study/widgets/webview1.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;
  const LocalNav({Key? key,required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child:  Padding(
        padding: const EdgeInsets.all(7),
        child: items(context),
      ),
    );
  }

  items(BuildContext context){
    if(localNavList.isEmpty) return null;

    List<Widget> items = [];
    // localNavList.map((model){
    //    items.add(item(context, model));
    // });

    for (var model in localNavList) {
      items.add(item(context, model));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

 Widget item(BuildContext context, CommonModel model){
     return GestureDetector(
       onTap: (){
         print(model.url ?? "");
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            WebViewPage(url: model.url ?? "",statusBarColor: model.statusBarColor ?? "faff",hideAppBar: model.hideAppBar ?? false, backForbid: false, title: model.title ?? "")
        )
        );
       },
       child: Column(
         children: [
           Image.network(
             model.icon,
             width: 32,
             height: 32,
           ),
           Text(
             model.title ?? "33",
             style: const TextStyle(fontSize: 12),
           )
         ],
       ),
     );
  }
}
