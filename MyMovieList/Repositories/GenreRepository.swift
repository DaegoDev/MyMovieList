//
//  GenreRepository.swift
//  MyMovieList
//

import Foundation

protocol GenreRepositoryProtocol {
  func fetchGenreList(completion: @escaping((Result<[Genre], Error>) -> Void))
}

final class GenreRepository: GenreRepositoryProtocol {
  private var apiClient: NetworkService
  
  init(apiClient: NetworkService = APIClient()) {
    self.apiClient = apiClient
  }
  
  func fetchGenreList(completion: @escaping((Result<[Genre], Error>) -> Void)) {
    apiClient.request(GenreListDataRequest()) { result in
      switch result {
      case .success(let response):
        completion(.success(response.genres.map { $0.toDomain() }))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
