import Cocoa
import CoreServices
import FlutterMacOS

public class DeeplinkXMacosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "deeplink_x_macos", binaryMessenger: registrar.messenger)
    let instance = DeeplinkXMacosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isBundleIDAvailable":
      guard let arguments = call.arguments as? [String: Any],
        let bundleID = arguments["bundleID"] as? String
      else {
        result(
          FlutterError(
            code: "INVALID_ARGUMENTS", message: "Missing or invalid bundleID parameter",
            details: nil)
        )
        return
      }
      result(checkBundleIDAvailability(bundleID: bundleID))
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func checkBundleIDAvailability(bundleID: String) -> Bool {
    return NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) != nil
  }
}
