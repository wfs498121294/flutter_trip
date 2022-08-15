
import 'dart:ui';
import 'package:flutter/material.dart';

double hcScreenWidth() {
  return window.physicalSize.width/window.devicePixelRatio;
}

double hcScreenHeight(){
  return window.physicalSize.height/window.devicePixelRatio;
}

double hcFitWidth(double width) {
  return hcScreenWidth()/375.0 *width;
}

double hcFitHeight(double height) {
  return hcScreenHeight()/667.0 *height;
}

double statusBarHeight = MediaQueryData.fromWindow(window).padding.top;

double getAppBarHeight() {
  // 将 AppBar 定义为变量
  var appBar = AppBar(
    title: const Text('XXX'),
  );
  // 获取高度
  return appBar.preferredSize.height;
}