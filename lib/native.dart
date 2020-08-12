import 'package:flutter/services.dart';
import 'dart:async';
const MethodChannel _channel = const MethodChannel("filetransfer");
class temp{
  String ps="";
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod("getPlatformVersion");
    print(version);
    return version;
  }
  static Future<Map> get getapkpath async{
    final Map m = await _channel.invokeMethod("getapkpath");
    print(m);
    return m;
  }
}
