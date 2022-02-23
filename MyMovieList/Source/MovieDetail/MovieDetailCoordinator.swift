//
//  MovieDetailCoordinator.swift
//  MyMovieList
//

import UIKit

protocol MovieDetailCoordinatorProtocol { }

final class MovieDetailCoordinator: Coordinator, MovieDetailCoordinatorProtocol {
  var childCoordinators: [Coordinator] = []
  var navigationController: UINavigationController
  var isCompleted: Observable<Bool>?
  
  private var movieId: Int
  
  init(navigationController: UINavigationController, movieId: Int) {
    self.navigationController = navigationController
    self.movieId = movieId
  }
  
  func start() {
    let viewModel = MovieDetailViewModel(movieId: movieId)
    let viewController = MovieDetailViewController()
    
    viewModel.coordinator = self
    viewController.viewModel = viewModel
    navigationController.pushViewController(viewController, animated: true)
  }
}
