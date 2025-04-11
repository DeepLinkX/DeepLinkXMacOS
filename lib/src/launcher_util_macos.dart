import 'package:deeplink_x_platform_interface/deeplink_x_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

/// A utility class for launching applications and handling intents on MacOS.
///
/// This class extends [LauncherUtilPlatform] and provides methods to check
/// if an Android app is installed, launch Android apps, and handle intents
/// for launching URLs and applications. It currently throws an error for
/// methods that are not implemented on the MacOS platform.
class LauncherUtilMacOS extends LauncherUtilPlatform {
  @override
  Future<bool> launchUrl(final Uri uri) async =>
      url_launcher.launchUrl(uri, mode: url_launcher.LaunchMode.externalApplication);

  @override
  Future<void> launchApp(final String scheme) async =>
      url_launcher.launchUrl(Uri.parse('$scheme://'), mode: url_launcher.LaunchMode.externalApplication);

  @override
  Future<bool> isAppInstalled(final String scheme) async => url_launcher.canLaunchUrl(Uri.parse('$scheme://'));

  @override
  Future<bool> isAndroidAppInstalled(final String packageName) async {
    throw UnimplementedError('isAndroidAppInstalled() not implemented on this platform.');
  }

  @override
  Future<void> launchAndroidApp(final String packageName) async {
    throw UnimplementedError('launchAndroidApp() not implemented on this platform.');
  }

  @override
  Future<void> launchIntent(final AndroidIntentOption options) async {
    throw UnimplementedError('launchIntent() not implemented on this platform.');
  }
}
