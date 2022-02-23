//
//  HomeCoordinator.swift
//  MyMovieList
//

import UIKit

protocol HomeCoordinatorProtocol: AnyObject {
  func goToMovieDetail(with movieId: Int)
}

final class HomeCoordinator: Coordinator, HomeCoordinatorProtocol {
  let navigationController: UINavigationController
  var childCoordinators: [Coordinator] = []
  var isCompleted: Observable<Bool>?

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let homeViewController = HomeViewController()
    let homeViewModel = HomeViewModel()
    
    homeViewModel.coordinator = self
    homeViewController.viewModel = homeViewModel
    
    homeViewController.hidesBottomBarWhenPushed = false
    navigationController.pushViewController(homeViewController, animated: true)
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
