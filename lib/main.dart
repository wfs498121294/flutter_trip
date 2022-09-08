import 'package:dokit/dokit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_study/navigator/tab_navigator.dart';


import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dokit/kit/apm/vm/vm_helper.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  List<String> blackList = [
    'plugins.flutter.io/sensors/gyroscope',
    'plugins.flutter.io/sensors/user_accel',
    'plugins.flutter.io/sensors/accelerometer'
  ];

  DoKit.runApp(
      app: DoKitApp(MyApp()),
      useInRelease: true,
      logCallback: (log) {
        String i = log;
      },
      methodChannelBlackList: blackList,
      exceptionCallback: (dynamic obj, StackTrace trace) {
        print('dokit exception callback: $obj');
      });

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoKit Test',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the kit.visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorObservers: [],
      home: TabNavigator(),
    );
  }
}


