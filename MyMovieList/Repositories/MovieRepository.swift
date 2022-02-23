//
//  MovieRepository.swift
//  MyMovieList
//

import Foundation

protocol MovieRepositoryProtocol {
  func fetchPopular(completion: @escaping((Result<[Movie], Error>) -> Void))
  
  func fetchMovieDetails(
    with movieId: String,
    completion: @escaping((Result<MovieDetail, Error>) -> Void)
  )
  
  func storeMovie(movie: Movie, completion: @escaping((Result<Movie, Error>) -> Void))
  func fetchStoredMovies(completion: @escaping((Result<[Movie], Error>) -> Void))
  func deleteStoredMovie(movie: Movie, completion: @escaping((Result<Bool, Error>) -> Void))
}

final class MovieRepository: MovieRepositoryProtocol {
  private var apiClient: NetworkService
  private var movieStorage: MovieDataStorageProtocol
  
  init(apiClient: NetworkService = APIClient(),
       movieStorage: MovieDataStorageProtocol = MovieDataStorage()) {
    self.apiClient = apiClient
    self.movieStorage = movieStorage
  }
  
  func fetchPopular(completion: @escaping((Result<[Movie], Error>) -> Void)) {
    apiClient.request(MoviePopularDataRequest()) { result in
      switch result {
      case .success(let response):
        let movies = response.results.compactMap { $0.toDomain() }
        completion(.success(movies))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func fetchMovieDetails(
    with movieId: String,
    completion: @escaping((Result<MovieDetail, Error>) -> Void)
  ) {
    apiClient.request(MovieDetailsDataRequest(movieId: movieId)) { result in
      switch result {
      case .success(let response):
        completion(.success(response.toDomain()))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func storeMovie(movie: Movie, completion: @escaping((Result<Movie, Error>) -> Void)) {
    movieStorage.saveMovies(movie: movie) { result in
      switch result {
      case .success(let movie):
        completion(.success(movie))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func fetchStoredMovies(completion: @escaping((Result<[Movie], Error>) -> Void)) {
    movieStorage.fetchMovies { result in
      switch result {
      case .success(let movies):
        completion(.success(movies.map({ $0.toDomain() })))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  func deleteStoredMovie(movie: Movie, completion: @escaping((Result<Bool, Error>) -> Void)) {
    movieStorage.deleteMovie(movie: movie) { result in
      switch result {
      case .success(let deleted):
        completion(.success(deleted))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
