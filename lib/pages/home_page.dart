import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_trip_study/common/device.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> imgUrls = [
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1115%2F092621094155%2F210926094155-9-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662801791&t=d7ae5fd64629c10a5123ffb5e08d88da",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F0Z320111T2%2F200Z3111T2-4-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662801791&t=6f20994de3907f775807e3235f6c4eb1",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1113%2F0F420110430%2F200F4110430-11-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662801791&t=5cdc0e8bb225bd24620197aa4c693c62",
  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg2.niutuku.com%2Fdesk%2F1208%2F0854%2Fbizhi-0854-1152.jpg&refer=http%3A%2F%2Fimg2.niutuku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662801791&t=31ed5ca5ec268741190fe62e85240249"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Column(
          children: [
            Container(
              width: hcScreenWidth(),
              height: hcFitWidth(300),
              child: Swiper(
                itemCount: imgUrls.length,
                autoplay: true,
                scrollDirection: Axis.horizontal,
                pagination: const SwiperPagination(alignment: Alignment.bottomRight),
                // control: const SwiperControl(),
                itemBuilder: (BuildContext context,int index){
                  return Image.network(
                    imgUrls[index],
                    fit: BoxFit.cover,
                  );
                },
                onTap: (index){
                  print(index);
                },
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
