import Flutter
import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseCore
import FirebaseMessaging
import ActivityKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey(Secrets.apiKey)
    GMSPlacesClient.provideAPIKey(Secrets.apiKey)
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    if let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.softing.move") {
      print("✅ Runner AppGroup container:", url.path)
    } else {
      print("❌ Runner AppGroup container NIL")
    }
    let auth = ActivityAuthorizationInfo()
    print("🧩 areActivitiesEnabled:", auth.areActivitiesEnabled)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
