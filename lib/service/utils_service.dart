import 'dart:io';

import 'package:mobile_device_identifier/mobile_device_identifier.dart';
class Utils{
  static Future<Map<String,String>>deviceParams()async{
    final _mobileDeviceIdentifier = MobileDeviceIdentifier();
    Map<String,String> params = {};
    var getDeviceId = await _mobileDeviceIdentifier.getDeviceId();
    String fcmToken="";

    if(Platform.isIOS){
      params.addAll({
        'device_id':getDeviceId!,
        'device_type':'IOS',
        'device_token':fcmToken,
      });
    }else{
      params.addAll({
        'device_id':getDeviceId!,
        'device_type':'ANDROID',
        'device_token':fcmToken,
      });
    }
    return params;
  }
  static String currentData(){
    DateTime now= DateTime.now();
    String convertedDataTime =
        '${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString()}:${now.minute.toString()}';
    return convertedDataTime;
  }
}