//
//  MovieRepositoryMock.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

final class MovieRepositoryMock: MovieRepositoryProtocol {
  struct Calls {
    var fetchPopularCalled: Bool = false
    var fetchMovieDetailsCalled: Bool = false
    var storeMovieCalled: Bool = false
    var fetchStoredMoviesCalled: Bool = false
    var deleteStoredMovieCalled: Bool = false
  }
  
  var calls = Calls()
    
  func fetchPopular(completion: @escaping((Result<[Movie], Error>) -> Void)) {
    let movies = [
      MovieMock.movieSpiderMan,
      MovieMock.movieEternals,
      MovieMock.movieKingsMan
    ]
    completion(.success(movies))
    calls.fetchPopularCalled = true
  }
  
  func fetchMovieDetails(
    with movieId: String,
    completion: @escaping((Result<MovieDetail, Error>) -> Void)
  ) {
    completion(.success(MovieDetailMock.spidermanDetails))
    calls.fetchMovieDetailsCalled = true
  }
  
  func storeMovie(movie: Movie, completion: @escaping((Result<Movie, Error>) -> Void)) {
    completion(.success(MovieMock.movieKingsMan))
    calls.storeMovieCalled = true

  }
  
  func fetchStoredMovies(completion: @escaping((Result<[Movie], Error>) -> Void)) {
    completion(.success([MovieMock.movieSpiderMan]))
    calls.fetchStoredMoviesCalled = true
  }
  
  func deleteStoredMovie(movie: Movie, completion: @escaping((Result<Bool, Error>) -> Void)) {
    completion(.success(true))
    calls.deleteStoredMovieCalled = true
  }
}
