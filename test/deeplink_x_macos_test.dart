// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('deeplink_x_macos');
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (final methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'getPlatformVersion':
            return 'macOS 10.15.7';
          case 'isBundleIDAvailable':
            if (methodCall.arguments == null) {
              throw PlatformException(
                code: 'INVALID_ARGUMENTS',
                message: 'Missing or invalid bundleID parameter',
              );
            }
            final String bundleID = methodCall.arguments['bundleID'] as String;
            if (bundleID == 'com.apple.Safari' || bundleID == 'com.apple.mail') {
              return true;
            } else if (bundleID == 'com.example.nonexistent') {
              return false;
            }
            return null;
          default:
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      null,
    );
    log.clear();
  });

  test('getPlatformVersion', () async {
    expect(
      await channel.invokeMethod<String>('getPlatformVersion'),
      'macOS 10.15.7',
    );
  });

  group('isBundleIDAvailable', () {
    test('returns true for existing bundle IDs', () async {
      expect(
        await channel.invokeMethod<bool>(
          'isBundleIDAvailable',
          {'bundleID': 'com.apple.Safari'},
        ),
        true,
      );

      expect(
        await channel.invokeMethod<bool>(
          'isBundleIDAvailable',
          {'bundleID': 'com.apple.mail'},
        ),
        true,
      );
    });

    test('returns false for non-existent bundle IDs', () async {
      expect(
        await channel.invokeMethod<bool>(
          'isBundleIDAvailable',
          {'bundleID': 'com.example.nonexistent'},
        ),
        false,
      );
    });

    test('handles missing parameters', () async {
      try {
        await channel.invokeMethod<bool>('isBundleIDAvailable');
        fail('Expected PlatformException');
      } on PlatformException catch (e) {
        expect(e.code, 'INVALID_ARGUMENTS');
        expect(e.message, 'Missing or invalid bundleID parameter');
      }
    });
  });
}
