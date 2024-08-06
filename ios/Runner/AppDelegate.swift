import UIKit
import Flutter
import AVFoundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "com.device.lamp_control/lamp"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window.rootViewController as! FlutterViewController
        let lampChannel = FlutterMethodChannel(name: channelName,
                                               binaryMessenger: controller.binaryMessenger)
        lampChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard call.method == "toggleLamp" else {
                result(FlutterMethodNotImplemented)
                return
            }
            guard let arguments = call.arguments as? [String: Bool],
                  let turnOn = arguments["turnOn"] else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected a boolean argument", details: nil))
                return
            }
            self?.toggleLamp(turnOn: turnOn, result: result)
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func toggleLamp(turnOn: Bool, result: @escaping FlutterResult) {
        guard let device = AVCaptureDevice.default(for: .video),
              device.hasTorch else {
            result(FlutterError(code: "UNAVAILABLE", message: "Torch not available.", details: nil))
            return
        }
        
        do {
            try device.lockForConfiguration()
            device.torchMode = turnOn ? .on : .off
            device.unlockForConfiguration()
            result(true)
        } catch {
            result(FlutterError(code: "ERROR", message: "Failed to toggle torch.", details: error.localizedDescription))
        }
    }
}
