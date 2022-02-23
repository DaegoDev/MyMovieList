//
//  FavoriteCoordinator.swift
//  MyMovieList
//

import UIKit

protocol FavoriteCoordinatorProtocol: AnyObject {
  func goToMovieDetail(with movieId: Int)
}

final class FavoriteCoordinator: Coordinator, FavoriteCoordinatorProtocol {
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  var isCompleted: Observable<Bool>?
  
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewModel = FavoriteViewModel()
    let viewController = FavoriteViewController()
    
    viewModel.coordinator = self
    viewController.viewModel = viewModel
    
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func goToMovieDetail(with movieId: Int) {
    let coordinator = MovieDetailCoordinator(
      navigationController: navigationController,
      movieId: movieId
    )
    
    store(coordinator: coordinator)
    coordinator.isCompleted?.bind { [weak self] isCompleted in
      self?.free(coordinator: coordinator)
    }
    coordinator.start()
  }
}
