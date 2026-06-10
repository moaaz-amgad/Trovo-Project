import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let didFinish = super.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )
    configurePhoneUsageChannel()
    return didFinish
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  private func configurePhoneUsageChannel() {
    guard let controller = window?.rootViewController as? FlutterViewController else {
      return
    }

    let channel = FlutterMethodChannel(
      name: "trovo_app/phone_usage",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "hasUsageAccess":
        result(false)
      case "openUsageAccessSettings":
        result(false)
      case "fetchUsageData":
        let formatter = ISO8601DateFormatter()
        result([
          "is_available": false,
          "message": "iOS does not expose app usage data without special entitlements.",
          "collected_at": formatter.string(from: Date()),
        ])
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
