//
//  PeopleRepository.swift
//  MyMovieList
//

import Foundation

protocol PeopleRepositoryProtocol {
  func fetchCast(with movieId: String, completion: @escaping((Result<[Person], Error>) -> Void))
}

final class PeopleRepository: PeopleRepositoryProtocol {
  private var apiClient: NetworkService
  
  init(apiClient: NetworkService = APIClient()) {
    self.apiClient = apiClient
  }
  
  func fetchCast(with movieId: String, completion: @escaping((Result<[Person], Error>) -> Void)) {
    apiClient.request(MovieCreditsDataRequest(movieId: movieId)) { result in
      switch result {
      case .success(let response):
        completion(.success(response.cast.map { $0.toDomain() }))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
