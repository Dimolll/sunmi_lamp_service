import 'dart:async';

import 'package:flutter/services.dart';

class SunmiLampService {
  static const MethodChannel _channel =
      const MethodChannel('sunmi_lamp_service');
  static int _tag = 0;

  static Future<bool> startForLoop(int status, String lamp) {
    int statusN = 0;
    if (_flag) {
      statusN = 0;
      _tag = 0;
    } else {
      statusN = 1;
      _tag = 1;
    }
    return _channel.invokeMethod(
      'startForLoop',
      <String, dynamic>{
        'status': statusN,
        'lamp': lamp,
      },
    );
  }

  static Future<bool> startForSigle(int status, String lamp) {
    int statusN = 0;
    if (_flag) {
      statusN = 0;
      _tag = 0;
    } else {
      statusN = 1;
      _tag = 1;
    }
    return _channel.invokeMethod(
      'startForSigle',
      <String, dynamic>{
        'status': statusN,
        'lamp': lamp,
      },
    );
  }

  static bool get _flag => _tag == 1;

  static Future<bool> closeAllLamp() => _channel.invokeMethod('closeAllLamp');
}
