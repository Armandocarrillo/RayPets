

import UIKit

public class HomeCoordinator: Coordinator {
  
  //MARK: - Instance Properties
  public var children: [Coordinator] = []
  public let router: Router
  
  //MARK: - Object Lifecycle
  public init(router: Router){
    self.router = router
  }
  
  //MARK:- Instance Methods
  public func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewController = HomeViewController.instantiate(delegate: self)
    router.present(viewController, animated: animated, onDismissed: onDismissed)
  }
}

//MARK: - HomeViewControllerDelegate
extension HomeCoordinator: HomeViewControllerDelegate {
  public func homeViewControllerDidPressScheduleAppointment(_ viewController: HomeViewController) {
    let router = ModalNavigationRouter(parentViewController: viewController)
    let coordinator = PetAppointmentBuilderCoordinator(router: router)
    presentChild(coordinator, animated: true)
  }
}

//MARK: - SelectVisitTypeViewControllerDelegate

extension PetAppointmentBuilderCoordinator: SelectVisitTypeViewControllerDelegate{
  
  public func selectVisitTypeViewController(_ controller: SelectVisitTypeViewController, didSelect visitType: VisitType){
    
    builder.visitType = visitType
    
    switch visitType {
    case .well:
      presentNoAppointmentViewController()
      
    case .sick:
      presentSelectPainLevelCoordinator()
      
    }
  }
  
  private func presentNoAppointmentViewController() {
    let viewController = NoAppointmentRequiredViewController.instantiate(delegate: self)
    router.present(viewController, animated: true)
  }
  
  private func presentSelectPainLevelCoordinator() {
    let viewController = SelectPainLevelViewController.instantiate(delegate: self)
    router.present(viewController, animated: true)
  }
}

//MARK: - SelectPainLevelViewControllerDelegate

extension PetAppointmentBuilderCoordinator: SelectPainLevelViewControllerDelegate {
  public func selectPainLevelViewController(_ controller: SelectPainLevelViewController, didSelect painLevel: PainLevel) {
    builder.painLevel = painLevel
    
    switch painLevel {
    case .none, .little:
      presentFakingItViewController()
    case .moderate, .severe, .worstPossible:
      presentNoAppointmentViewController()
    }
  }
  
  private func presentFakingItViewController() {
    let viewController = FakingItViewController.instantiate(delegate: self)
    router.present(viewController, animated: true)
  }
}

//MARK: -FakingItViewControllerDelegate

extension PetAppointmentBuilderCoordinator: FakingItViewControllerDelegate {
  
  
  public func fakingItViewControllerPressedNotFake(_ controller: FakingItViewController) {
    presentNoAppointmentViewController()
  }
  
  public func fakingItViewControllerPressedIsFake(_ controller: FakingItViewController) {
    router.dismiss(animated: true)
  }
  
  
}

//MARK: - NoAppointmentRequiredViewControllerDelegate

extension PetAppointmentBuilderCoordinator : NoAppointmentRequiredViewControllerDelegate {
  public func noAppointmentViewControllerDidPressOkay(_ controller: NoAppointmentRequiredViewController) {
    router.dismiss(animated: true)
  }
    
}
