import 'package:flutter/material.dart';
import 'package:flutter_trip_study/model/common_model.dart';
import 'package:flutter_trip_study/widgets/webview1.dart';
import '../model/sales_box_model.dart';

class SalesBox extends StatelessWidget {
   SalesBoxModel? salesBox;
   SalesBox({Key? key,required this.salesBox}) : super(key: key);

   _items(BuildContext context){
    if (salesBox == null) {
      return null;
    }

    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1,color: Color(0xfff2f2f2)))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(salesBox?.icon ?? "",height: 15,fit: BoxFit.fill,),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: const EdgeInsets.only(right: 7),
                decoration:  BoxDecoration(
                   borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(colors: [Color(0xffff4e63),Color(0xffff6cc9)],begin: Alignment.centerLeft,end: Alignment.centerRight)
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        WebViewPage(url: salesBox?.moreUrl  ?? "", title: "更多活动", statusBarColor: 'faff', backForbid: false, hideAppBar: false,)
                    )
                    );
                  },
                  child: const Text("获取更多福利 >",style: TextStyle(fontSize: 12,color: Colors.white),),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _doubleItem(context, (salesBox?.bigCard1)!,(salesBox?.bigCard2)!,true,false)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _doubleItem(context, (salesBox?.smallCard1)!,(salesBox?.smallCard2)!,false,false)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _doubleItem(context, (salesBox?.smallCard3)!,(salesBox?.smallCard4)!,false,false)
          ],
        )
      ],
    );
  }

  _doubleItem(BuildContext context,CommonModel firstModel,CommonModel secondModel,bool big,bool last){
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(context, firstModel,true,big,last),
          _item(context, secondModel,false,big,last),
        ],
      ),
    );
  }

  _item(BuildContext context,CommonModel? model,bool left,bool big,bool last){

     BorderSide borderSide = const BorderSide(width: 0.8,color: Color(0xfff2f2f2));
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            WebViewPage(url: model?.url ?? "",statusBarColor: model?.statusBarColor ?? "faff",hideAppBar: model?.hideAppBar ?? false, backForbid: false, title: model?.title ?? "")
        )
        );
      },
      child: Container(
        decoration:  BoxDecoration(
            border:Border(right: left ? borderSide:BorderSide.none,bottom: !last ? borderSide:BorderSide.none)
        ),
        child: Image.network(
          model?.icon ?? "",
          width: MediaQuery.of(context).size.width/2-10,
          height: big ? 129:80,
          fit: BoxFit.fill,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white
      ),
      child: _items(context),
    );
  }
}
