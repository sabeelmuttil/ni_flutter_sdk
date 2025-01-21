import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ni_flutter_sdk_platform_interface.dart';

/// An implementation of [NiFlutterSdkPlatform] that uses method channels.
class MethodChannelNiFlutterSdk extends NiFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ni_flutter_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
