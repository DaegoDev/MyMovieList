//
//  PeopleRepositoryMock.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

final class PeopleRepositoryMock: PeopleRepositoryProtocol {
  struct Calls {
    var fetchCastCalled: Bool = false
  }
  
  var calls = Calls()
  
  func fetchCast(with movieId: String, completion: @escaping((Result<[Person], Error>) -> Void)) {
    completion(.success(PersonMock.allPeople))
    calls.fetchCastCalled = true
  }
}
