// import Flutter
// import UIKit
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
import UIKit
import CallKit
import AVFAudio
import PushKit
import Flutter
import flutter_callkit_incoming

@main
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate {
    var flutterCallkitIncoming: SwiftFlutterCallkitIncomingPlugin?
    var voipToken: String?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        // Setup VOIP
        let mainQueue = DispatchQueue.main
        let voipRegistry: PKPushRegistry = PKPushRegistry(queue: mainQueue)
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // Delegate method to get VoIP token
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        if type == .voIP {
            let deviceToken = pushCredentials.token.map { String(format: "%02x", $0) }.joined()
            voipToken = deviceToken
            // Send the VoIP token to Flutter using a platform channel
            if let voipToken = voipToken {
                sendVoIPTokenToFlutter(token: voipToken)
            }
        }
    }

    // Function to send the VoIP token to Flutter
    private func sendVoIPTokenToFlutter(token: String) {
        if let flutterViewController = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: "com.gokidu/voipToken", binaryMessenger: flutterViewController.binaryMessenger)
            channel.invokeMethod("onVoIPTokenReceived", arguments: token)
        }
    }

    // Handle incoming pushes
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        print("didReceiveIncomingPushWith")
        print(payload.dictionaryPayload)
        guard type == .voIP else { return }

        let id = /*payload.dictionaryPayload["userId"] as? String ??*/ UUID().uuidString
        let nameCaller = payload.dictionaryPayload["call_from"] as? String ?? ""
        let handle = payload.dictionaryPayload["channel_id"] as? String ?? ""
        let isVideo = payload.dictionaryPayload["call_type"] as? String ?? "0"

        let data = flutter_callkit_incoming.Data(id: id, nameCaller: nameCaller, handle: handle, type: isVideo=="1" ? 1 : 0)
        //set more data
        data.extra = ["userId": payload.dictionaryPayload["userId"] as? String ?? "", "platform": "ios"]
        SwiftFlutterCallkitIncomingPlugin.sharedInstance?.showCallkitIncoming(data, fromPushKit: true)

        // Make sure call completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion()
        }
    }

    func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
        print("didInvalidatePushTokenFor")
        SwiftFlutterCallkitIncomingPlugin.sharedInstance?.setDevicePushTokenVoIP("")
    }
}

