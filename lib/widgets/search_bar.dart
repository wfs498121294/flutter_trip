
import 'package:flutter/cupertino.dart';

enum SearchBarType {
  home,
  normal,
  homeLight
}
class SearchBar extends StatefulWidget {

  final bool enabled;
  final bool hideLeft;
  final String hint;
  final String  defaultText;
  final Function() onLeftBtnClick;
  final Function() onRightBtnClick;
  final SearchBarType searchBarType;

   SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
