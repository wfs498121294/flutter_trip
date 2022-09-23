
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SearchBarType {
  home,
  normal,
  homeLight
}
class SearchBar extends StatefulWidget {

  final bool enabled;
  final bool ? hideLeft;
  final String hint;
  final String  defaultText;
  final Function()? onLeftBtnClick;
  final Function()? onRightBtnClick;
  final Function()? speakClick;
  final Function()? inputBoxClick;
  final Function(String)? onChange;
  final SearchBarType searchBarType;

   const SearchBar({Key? key, this.enabled = true, required this.hint, required this.defaultText, this.onLeftBtnClick, this.onRightBtnClick, this.speakClick,  this.inputBoxClick,this.searchBarType = SearchBarType.normal, this.onChange, this.hideLeft}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if(widget.defaultText != null){
        setState(() {
          _controller.text = widget.defaultText;
        });
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal ? _getNormalSearch():_getHomeSearch();
  }

  _getNormalSearch(){

    return Row(
      children: [
        _wrapTap(Container(
          padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
          child: widget.hideLeft ?? false ? null : const Icon(Icons.arrow_back_ios,color: Colors.grey,size: 26),
        ),
            widget.onLeftBtnClick
        ),
        Expanded(
          child: _inputBox(),
          flex: 1,
        ),
        _wrapTap(Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: const Text(
            '搜索',
            style: TextStyle(color: Colors.blue,fontSize: 17),
          ),
        ), widget.onRightBtnClick)
      ],
    );

  }

  _getHomeSearch(){
    return Row(
      children: [
        _wrapTap(Container(
          padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
          child:Row(
            children: [
              Text("广州",style: TextStyle(fontSize: 14,color: _homeFontColor()),),
              Icon(
                Icons.expand_more,
                color: _homeFontColor(),
                size: 22,
              )
            ],
          ),
        ),
            widget.onLeftBtnClick
        ),
        Expanded(
          child: _inputBox(),
          flex: 1,
        ),
        _wrapTap(Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Icon(
            Icons.comment,
            color: _homeFontColor(),
            size: 26,
          )
        ), widget.onRightBtnClick)
      ],
    );
  }
  _inputBox(){
    Color inputBoxColor = Colors.white;
    Color searchColor = Colors.blue;
    if(widget.searchBarType != SearchBarType.home){
        inputBoxColor = Color(int.parse('0xffededed'));
    }

    if(widget.searchBarType != SearchBarType.normal){
      searchColor = Color(int.parse('0xffa9a9a9'));
    }

    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
          widget.searchBarType == SearchBarType.normal ? 5 : 15
        )
      ),
      child: Row(
        children: [
          Icon(Icons.search,size: 20,color: searchColor),
          Expanded(
            flex: 1,
              child: widget.searchBarType == SearchBarType.normal ? TextField(
                controller: _controller,
                onChanged: _onChange,
                autofocus: true,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      border: const OutlineInputBorder(borderSide: BorderSide.none),//border 不能直接使用InputBorder.none 会不居中
                      hintText: widget.hint ?? "",
                      hintStyle: const TextStyle(fontSize: 13)
                  )
              ) : _wrapTap(
                  Container(
                child: Text(
                  widget.defaultText,
                  style: const TextStyle(fontSize: 13,color: Colors.grey),
                ),
              ), widget.inputBoxClick)
          ),
          !_showClear? _wrapTap(Icon(Icons.mic,size: 15,color: widget.searchBarType == SearchBarType.normal ? Colors.blue : Colors.grey,), widget.speakClick) : _wrapTap(Icon(Icons.clear,size: 15,color: Colors.grey), () {
            setState(() {
              _controller.clear();
            });
          })
        ],
      ),
    );
  }

  _wrapTap(Widget child,void Function()? callBack){
    return GestureDetector(
      onTap: (){
        if(callBack != null){
           callBack();
        }
      },
      child: child,
    );
  }

  _onChange(String text){
    print(text.length);
    if(text.isNotEmpty){
      setState(() {
        _showClear = true;
        print(_showClear);
      });
    }
    else{
      setState(() {
        _showClear = false;
        print(_showClear);

      });
    }

    if(widget.onChange != null){
      widget.onChange!(text);
    }


  }

  _homeFontColor(){
    return widget.searchBarType == SearchBarType.homeLight ? Colors.black54 : Colors.white;
  }
}
