import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceInfoCollector {
  static final _deviceInfo = DeviceInfoPlugin();

  static Future<Map<String, dynamic>> collect() async {
    if (Platform.isAndroid) {
      final android = await _deviceInfo.androidInfo;
      return {
        "platform": "Android",
        "model": android.model,
        "manufacturer": android.manufacturer,
        "brand": android.brand,
        "version": android.version.release,
      };
    } else if (Platform.isIOS) {
      final ios = await _deviceInfo.iosInfo;
      return {
        "platform": "iOS",
        "model": ios.utsname.machine,
        "systemName": ios.systemName,
        "systemVersion": ios.systemVersion,
      };
    }
    return {"platform": "Unknown"};
  }
}
