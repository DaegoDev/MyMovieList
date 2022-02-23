//
//  Coordinator.swift
//  MyMovieList
//

import UIKit

protocol Coordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController? { get }
  var tabBarController: UITabBarController? { get }
  var isCompleted: Observable<Bool>? { get set }
  
  func start()
  func store(coordinator: Coordinator)
  func free(coordinator: Coordinator)
}

extension Coordinator {
  var navigationController: UINavigationController? {
    nil
  }
  
  var tabBarController: UITabBarController? {
    nil
  }
  
  func store(coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }
  
  func free(coordinator: Coordinator) {
    childCoordinators = childCoordinators.filter { $0 !== coordinator }
  }
}
