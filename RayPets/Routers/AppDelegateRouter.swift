
import UIKit
//to hold onto the window from appdelegate
public class AppDelegateRouter: Router {
  // MARK: -Intasnce Properties
  
  public let window: UIWindow
  
  //MARK: - Object Lifecycle
  public init(window: UIWindow) {
    self.window = window
  }
  
  //MARK: -Router
  //to set the rootViewController and call makeKey
  public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  public func dismiss(animated: Bool) {
    
  }
}
