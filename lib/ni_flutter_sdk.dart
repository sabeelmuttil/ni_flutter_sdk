
import 'ni_flutter_sdk_platform_interface.dart';

class NiFlutterSdk {
  Future<String?> getPlatformVersion() {
    return NiFlutterSdkPlatform.instance.getPlatformVersion();
  }
}
