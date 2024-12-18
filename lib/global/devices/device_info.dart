import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class DeviceInfo {
  // get the device name depends on it's type
  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    // if device is ios
    if (GetPlatform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.utsname.machine ?? '';
    }
    // if device is android
    else if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.model;
    }
    // if it's a web
    else if (GetPlatform.isWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      return webBrowserInfo.browserName.name;
    }
    // if is windows
    else if (GetPlatform.isWindows) {
      WindowsDeviceInfo webBrowserInfo = await deviceInfo.windowsInfo;
      return webBrowserInfo.computerName;
    }

    // if device is linux
    else if (GetPlatform.isLinux) {
      LinuxDeviceInfo linuxDeviceInfo = await deviceInfo.linuxInfo;
      return linuxDeviceInfo.name;
    }

    // if device is mac
    else if (GetPlatform.isMacOS) {
      MacOsDeviceInfo macOsDeviceInfo = await deviceInfo.macOsInfo;
      return macOsDeviceInfo.computerName;
    }
    return '';
  }
}
