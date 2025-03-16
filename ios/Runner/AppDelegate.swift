import Flutter
import UIKit
#import "GoogleMaps/GoogleMaps.h"

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     [GMSServices provideAPIKey:@"AIzaSyB6sX6V1y9owR5_DFOIbqYoCjktd1RORVs"];
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
