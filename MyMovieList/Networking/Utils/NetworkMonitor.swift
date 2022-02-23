//
//  NetworkMonitor.swift
//  MyMovieList
//

import Foundation
import Network

final class NetworkMonitor {
  static let shared = NetworkMonitor()
  
  private let networkMonitorQueue = "networkMonitorQueue"
  private let monitor = NWPathMonitor()
  private var lastStatus: NWPath.Status = .requiresConnection
  
  var isReachable: Bool { lastStatus == .satisfied }
  
  func start() {
    monitor.pathUpdateHandler = { [weak self] path in
      self?.lastStatus = path.status
    }
    
    let queue = DispatchQueue(label: networkMonitorQueue)
    monitor.start(queue: queue)
  }
  
  func stop() {
    monitor.cancel()
  }
}
