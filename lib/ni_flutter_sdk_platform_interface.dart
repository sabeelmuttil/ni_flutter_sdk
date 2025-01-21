import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ni_flutter_sdk_method_channel.dart';

abstract class NiFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a NiFlutterSdkPlatform.
  NiFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static NiFlutterSdkPlatform _instance = MethodChannelNiFlutterSdk();

  /// The default instance of [NiFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelNiFlutterSdk].
  static NiFlutterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NiFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(NiFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
