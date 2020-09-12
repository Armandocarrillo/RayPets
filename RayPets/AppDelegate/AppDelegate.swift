

import UIKit

@UIApplicationMain
public class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: - Instance Properties
  
  public lazy var coordinator = HomeCoordinator(router: router)
  public lazy var router = AppDelegateRouter(window: window!)
  public lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
  


  // MARK: - Application Lifecycle
  public func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //To start the HomeCoordinator flow
    coordinator.present(animated: true, onDismissed: nil)
    return true
  }
}
