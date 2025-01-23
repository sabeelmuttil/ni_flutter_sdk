import 'package:flutter/src/services/message_codec.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ni_flutter_sdk/ni_flutter_sdk.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNiFlutterSdkPlatform
    with MockPlatformInterfaceMixin
    implements NiSdk {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void dispose() {}

  @override
  StatefulWidget hyperSdkView(Map<String, dynamic> params,
      void Function(MethodCall p1) processHandler) {
    throw UnimplementedError();
  }

  @override
  Future<String> makeCardPayment() {
    throw UnimplementedError();
  }

  @override
  Future<String> makeSamsungPay() {
    throw UnimplementedError();
  }
}

void main() {
  final NiSdk initialPlatform = NiSdk();

  test('$NiSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<NiSdk>());
  });

  test('getPlatformVersion', () async {
    NiSdk niSdkPlugin = NiSdk();

    expect(await niSdkPlugin.getPlatformVersion(), '42');
  });
}
