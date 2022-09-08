import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;


  const LoadingContainer({Key? key,required this.isLoading,this.cover = false,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List <Widget> items = [];
    items.add(child);
    if(isLoading){
      items.add(_loadingView);
    }

    return !cover ? !isLoading ? child: _loadingView : Stack(
      children: items,
    );
  }

  Widget get _loadingView{
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
