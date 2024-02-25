import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    
    GMSServices.provideAPIKey("AIzaSyAz9sHZe25LtBkA0ujUCMy472amlfrJCes") //static api 키 추가
    // GMSServices.provideAPIKey("AIzaSyA0ayzchxjv-MycWT0bmvaxRt8he2RYsJA") //ios api 키 추가
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
