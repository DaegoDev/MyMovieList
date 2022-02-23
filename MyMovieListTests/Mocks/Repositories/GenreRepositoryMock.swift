//
//  GenreRepositoryMock.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

final class GenreRepositoryMock: GenreRepositoryProtocol {
  struct Calls {
    var fetchGenreListCalled: Bool = false
  }
  
  var calls = Calls()
  func fetchGenreList(completion: @escaping((Result<[Genre], Error>) -> Void)) {
    completion(.success(GenreMock.allGenres))
    calls.fetchGenreListCalled = true
  }
}
