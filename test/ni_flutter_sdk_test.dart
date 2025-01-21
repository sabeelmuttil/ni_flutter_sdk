import 'package:flutter_test/flutter_test.dart';
import 'package:ni_flutter_sdk/ni_flutter_sdk.dart';
import 'package:ni_flutter_sdk/ni_flutter_sdk_platform_interface.dart';
import 'package:ni_flutter_sdk/ni_flutter_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNiFlutterSdkPlatform
    with MockPlatformInterfaceMixin
    implements NiFlutterSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NiFlutterSdkPlatform initialPlatform = NiFlutterSdkPlatform.instance;

  test('$MethodChannelNiFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNiFlutterSdk>());
  });

  test('getPlatformVersion', () async {
    NiFlutterSdk niFlutterSdkPlugin = NiFlutterSdk();
    MockNiFlutterSdkPlatform fakePlatform = MockNiFlutterSdkPlatform();
    NiFlutterSdkPlatform.instance = fakePlatform;

    expect(await niFlutterSdkPlugin.getPlatformVersion(), '42');
  });
}
