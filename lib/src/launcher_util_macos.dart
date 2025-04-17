import 'package:deeplink_x_platform_interface/deeplink_x_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// A utility class for launching applications and handling intents on MacOS.
///
/// This class extends [LauncherUtilPlatform] and provides methods to check
/// if an Android app is installed, launch Android apps, and handle intents
/// for launching URLs and applications. It currently throws an error for
/// methods that are not implemented on the MacOS platform.
class LauncherUtilMacOS extends LauncherUtilPlatform {
  /// Registers this class as the default instance of [LauncherUtilMacOS].
  static void registerWith() {
    LauncherUtilPlatform.instance = LauncherUtilMacOS();
  }

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel = const MethodChannel('deeplink_x_macos');

  @override
  Future<bool> launchUrl(final Uri uri) async =>
      url_launcher.launchUrl(uri, mode: url_launcher.LaunchMode.externalApplication);

  @override
  Future<bool> launchAppByScheme(final String scheme) async =>
      url_launcher.launchUrl(Uri.parse('$scheme://'), mode: url_launcher.LaunchMode.externalApplication);

  @override
  Future<bool> isAppInstalledByScheme(final String scheme) async {
    throw UnimplementedError('isAppInstalledByScheme() not implemented on this platform.');
  }

  @override
  Future<bool> isAppInstalledByPackageName(final String packageName) async {
    try {
      final bool isAvailable = await methodChannel.invokeMethod<bool>(
            'isBundleIDAvailable',
            {'bundleID': packageName},
          ) ??
          false;
      return isAvailable;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<bool> launchAppByPackageName(final String packageName) async {
    throw UnimplementedError('launchAppByPackageName() not implemented on this platform.');
  }

  @override
  Future<void> launchIntent(final AndroidIntentOption options) async {
    throw UnimplementedError('launchIntent() not implemented on this platform.');
  }
}
