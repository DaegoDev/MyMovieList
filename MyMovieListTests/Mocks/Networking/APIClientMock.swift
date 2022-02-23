//
//  APIClientMock.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

final class APIClientMock: NetworkService {
  var path = ""
  var headers: [String: String] = [:]
  var queryItems: [String: String] = [:]
  var method: HTTPMethod = .patch
  
  var responseFile: JsonFileList = .none

  func request<Request>(
    _ request: Request,
    completion: @escaping (Result<Request.Response, Error>) -> Void
  ) where Request : DataRequest {
    self.path = request.path
    self.headers = request.headers
    self.queryItems = request.queryItems
    self.method = request.method
    
    if let data = loadJsonData() {
      do {
        completion(.success(try request.decode(data)))
      }
      catch (let error) {
        completion(.failure(ErrorResponse.parsingError(error: error.localizedDescription)))
      }
    } else {
      completion(.failure(ErrorResponse.serializarionError))
    }
  }
  
  private func loadJsonData() -> Data? {
    guard let pathString = Bundle(for: type(of: self)).path(forResource: responseFile.fileName, ofType: "json") else {
      return nil
    }
    
    do {
      return try Data(contentsOf: URL(fileURLWithPath: pathString), options: .mappedIfSafe)
    } catch(let error) {
      print(error)
      return nil
    }
  }
}
