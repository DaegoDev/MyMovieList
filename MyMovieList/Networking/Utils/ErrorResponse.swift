//
//  ErrorResponse.swift
//  MyMovieList
//

import Foundation

enum ErrorResponse: Error {
  case parsingError(error: String)
  case apiError
  case noData
  case serializarionError
  case invalidResponse
  case invalidEndpoint
  case notFound
  case notConnectedToInternet
  
  var errorDescription: String {
    switch self {
    case .parsingError(error: let error):
      return "Cannot parse response: \(error)"
    case .apiError:
      return "Something went wrong with the API"
    case .noData:
      return "Something went wrong the service data"
    case .serializarionError:
      return "Cannot serialize model"
    case .invalidEndpoint:
      return "Something went wrong with the service endpoint"
    case .invalidResponse:
      return "Something went wrong with the service response"
    case .notFound:
      return "Cannot reach service endpoint"
    case .notConnectedToInternet:
      return "Cannot reach service due to internet connection issues"

    }
  }
}
