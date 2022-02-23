//
//  NetworkService.swift
//  MyMovieList
//

import Foundation
import Network

enum HTTPHeader: String {
  case apiKey = "api_key"
  case contentType = "Content-Type"
}

final class APIClient: NetworkService {
  private var serviceConfiguration: ServiceConfiguration
  
  init(serviceConfiguration: ServiceConfiguration = DefaultServiceConfiguration()) {
    self.serviceConfiguration = serviceConfiguration
  }
  
  func request<Request: DataRequest>(
    _ request: Request,
    completion: @escaping (Result<Request.Response, Error>) -> Void
  ) {
    guard NetworkMonitor.shared.isReachable else {
      return completion(.failure(ErrorResponse.notConnectedToInternet))
    }
    
    let serviceUrl = serviceConfiguration.url + request.path
    
    guard var urlComponents = URLComponents(string: serviceUrl) else {
      return completion(.failure(ErrorResponse.invalidEndpoint))
    }
     
    urlComponents.queryItems = getQueryItems(with: request)
    
    guard let url = urlComponents.url else {
      return completion(.failure(ErrorResponse.invalidEndpoint))
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = getHeaders(with: request)
    urlRequest.httpBody = request.serviceRSO?.toJSONData()
        
    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      if let error = error {
        return completion(.failure(error))
      }
      
      guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
        return completion(.failure(ErrorResponse.invalidResponse))
      }
      
      guard let data = data else {
        return completion(.failure(ErrorResponse.noData))
      }

      do {
        try completion(.success(request.decode(data)))
      } catch let error {
        print(error)
        completion(.failure(error))
      }
    }
    .resume()
  }
  
  private func getQueryItems<Request: DataRequest>(with request: Request) -> [URLQueryItem] {
    let allQueryItems = serviceConfiguration.queryItems + request.queryItems
    let urlQueryItems = allQueryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
    return urlQueryItems
  }
  
  private func getHeaders<Request: DataRequest>(with request: Request) -> [String: String] {
    return serviceConfiguration.headers + request.headers
  }
}
