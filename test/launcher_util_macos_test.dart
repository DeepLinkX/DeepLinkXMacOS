import 'package:deeplink_x_macos/src/launcher_util_macos.dart';
import 'package:deeplink_x_platform_interface/deeplink_x_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMethodChannel extends Mock implements MethodChannel {}

// Custom test class that extends LauncherUtilMacOS to allow overriding the method channel
class TestLauncherUtilMacOS extends LauncherUtilMacOS {
  TestLauncherUtilMacOS(this._mockMethodChannel);

  final MethodChannel _mockMethodChannel;

  @override
  MethodChannel get methodChannel => _mockMethodChannel;

  // Override to return controlled results for testing
  @override
  Future<bool> launchAppByScheme(final String scheme) async {
    throw UnimplementedError('launchAppByScheme() not implemented on this platform.');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TestLauncherUtilMacOS launcherUtil;
  late MockMethodChannel mockMethodChannel;

  setUp(() {
    mockMethodChannel = MockMethodChannel();
    launcherUtil = TestLauncherUtilMacOS(mockMethodChannel);
  });

  group('LauncherUtil', () {
    // Tests for unimplemented methods
    group('unimplemented methods', () {
      test('isAppInstalledByScheme throws UnimplementedError', () {
        expect(
          () => launcherUtil.isAppInstalledByScheme('com.example.app'),
          throwsA(isA<UnimplementedError>()),
        );
      });

      test('launchAppByScheme throws UnimplementedError', () {
        expect(
          () => launcherUtil.launchAppByScheme('com.example.app'),
          throwsA(isA<UnimplementedError>()),
        );
      });

      test('launchIntent throws UnimplementedError', () {
        expect(
          () => launcherUtil.launchIntent(const AndroidIntentOption(action: '')),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });

    // Tests for bundle ID related methods
    group('bundle ID methods', () {
      test('isAppInstalledByPackageName returns true when bundle ID is available', () async {
        const bundleID = 'com.example.app';

        when(
          () => mockMethodChannel.invokeMethod<bool>(
            'isBundleIDAvailable',
            {'bundleID': bundleID},
          ),
        ).thenAnswer((final _) async => true);

        final result = await launcherUtil.isAppInstalledByPackageName(bundleID);
        expect(result, true);
      });

      test('isAppInstalledByPackageName returns false when bundle ID is not available', () async {
        const bundleID = 'com.example.nonexistent';

        when(
          () => mockMethodChannel.invokeMethod<bool>(
            'isBundleIDAvailable',
            {'bundleID': bundleID},
          ),
        ).thenAnswer((final _) async => false);

        final result = await launcherUtil.isAppInstalledByPackageName(bundleID);
        expect(result, false);
      });

      test('isAppInstalledByPackageName returns false when method channel throws exception', () async {
        const bundleID = 'com.example.error';

        when(
          () => mockMethodChannel.invokeMethod<bool>(
            'isBundleIDAvailable',
            {'bundleID': bundleID},
          ),
        ).thenThrow(PlatformException(code: 'ERROR'));

        final result = await launcherUtil.isAppInstalledByPackageName(bundleID);
        expect(result, false);
      });
    });
  });

  // TODO: UnitTests for url_launcher related methods
  // TODO: UnitTests for android_intent_plus related methods
}
