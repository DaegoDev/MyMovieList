//
//  ReviewRepository.swift
//  MyMovieList
//

import Foundation

protocol ReviewRepositoryProtocol {
  func fetchReviews(with movieId: String, completion: @escaping((Result<[Review], Error>) -> Void))
}

final class ReviewRepository: ReviewRepositoryProtocol {
  private var apiClient: APIClient
  
  init(apiClient: APIClient = APIClient()) {
    self.apiClient = apiClient
  }
  
  func fetchReviews(with movieId: String, completion: @escaping((Result<[Review], Error>) -> Void)) {
    apiClient.request(ReviewDataRequest(movieId: movieId)) { result in
      switch result {
      case .success(let response):
        completion(.success(response.results.map { $0.toDomain() }))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
