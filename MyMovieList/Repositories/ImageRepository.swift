//
//  ImageRepository.swift
//  MyMovieList
//

import Foundation

protocol ImageRepositoryProtocol {
  func fetchImage(path: String, completion: @escaping((Result<Data, Error>) -> Void))
}

final class ImageRepository: ImageRepositoryProtocol {
  private var apiClient: APIClient
  
  init(apiClient: APIClient = APIClient(serviceConfiguration: DefaultImageServiceConfiguration())) {
    self.apiClient = apiClient
  }
  
  func fetchImage(path: String, completion: @escaping((Result<Data, Error>) -> Void)) {
    let imageRequest = ImageDataRequest(path: path)
    apiClient.request(imageRequest) { result in
      if case let .success(response) = result {
        DispatchQueue.main.async {
          completion(.success(response))
        }
      }
    }
  }
}
