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
      // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyCPJul9Lcbk-2UTzwUzSybIYUilVr8jyic")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
