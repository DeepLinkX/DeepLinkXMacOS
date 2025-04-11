import 'package:deeplink_x_macos/src/launcher_util_macos.dart';
import 'package:deeplink_x_platform_interface/deeplink_x_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LauncherUtilMacOS launcherUtil;

  setUp(() {
    launcherUtil = LauncherUtilMacOS();
  });

  group('LauncherUtil', () {
    // Tests for unimplemented methods
    group('unimplemented methods', () {
      test('isAndroidAppInstalled throws UnimplementedError', () {
        expect(
          () => launcherUtil.isAndroidAppInstalled('com.example.app'),
          throwsA(isA<UnimplementedError>()),
        );
      });

      test('launchAndroidApp throws UnimplementedError', () {
        expect(
          () => launcherUtil.launchAndroidApp('com.example.app'),
          throwsA(isA<UnimplementedError>()),
        );
      });

      test('launchIntent throws UnimplementedError', () {
        expect(
          () => launcherUtil.launchIntent(AndroidIntentOption(action: '')),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });
  });

  // TODO: UnitTests for url_launcher related methods
  // TODO: UnitTests for android_intent_plus related methods
}
