import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Register Google Maps
    registerGoogleMaps()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


// Google Maps API Key
extension AppDelegate {

    private func registerGoogleMaps() {
        GMSServices.provideAPIKey("AIzaSyCtXOM6sUPtvRZHigIwykHa5UZLbQo2gHA")
    }
  
}