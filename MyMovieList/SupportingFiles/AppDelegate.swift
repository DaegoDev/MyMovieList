//
//  AppDelegate.swift
//  MyMovieList
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: AppCoordinator?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let window = UIWindow(frame: UIScreen.main.bounds)
    self.appCoordinator = AppCoordinator(window: window)
    self.window = window
    
    appCoordinator?.start()
    NetworkMonitor.shared.start()
    
    return true
  }
}
