

import UIKit

public class PetAppointmentBuilderCoordinator: Coordinator {
  //MARK: - Instance Properties
  
  public let builder = PetAppointmentBuilder()
  public var children: [Coordinator] = []
  public let router: Router
  
  //MARK: - Object Lifecycle
  public init(router: Router) {
    self.router = router
  }
  //MARK: - Instance Methods
  public func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewController = SelectVisitTypeViewController.instantiate(delegate: self)
    router.present(viewController, animated: animated, onDismissed: onDismissed)
  }
}
