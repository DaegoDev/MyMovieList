//
//  HomeCoordinatorMock.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

final class HomeCoordinatorMock: HomeCoordinatorProtocol {
  struct Calls {
    var goToMovieDetailCalled = false
  }
  
  var calls = Calls()
  
  func goToMovieDetail(with movieId: Int) {
    calls.goToMovieDetailCalled = true
  }
}
