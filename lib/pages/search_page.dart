import 'package:flutter/material.dart';
import 'package:flutter_trip_study/widgets/search_bar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("下拉刷新"),
      ),
      body:Column(
        children:  [
          SearchBar(hideLeft: true, hint: "请输入关键词", defaultText: "天安门", searchBarType: SearchBarType.normal,onChange: _onTextChange,)
        ],
      )
    );
  }

  _onTextChange(text){
    print(text);
  }
}
