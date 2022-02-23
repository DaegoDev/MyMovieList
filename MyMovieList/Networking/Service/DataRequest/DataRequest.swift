//
//  DataRequest.swift
//  MyMovieList
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

protocol DataRequest {
  associatedtype Response
  
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String] { get }
  var queryItems: [String: String] { get }
  var serviceRSO: Encodable? { get }
  
  func decode(_ data: Data) throws ->  Response
}

extension DataRequest where Response: Decodable {
  func decode(_ data: Data) throws -> Response {
    return try JSONDecoder().decode(Response.self, from: data)
  }
}

extension DataRequest {
  var headers: [String: String] {
    [:]
  }
  
  var queryItems: [String: String] {
    [:]
  }
  
  var serviceRSO: Encodable? {
    nil
  }
}
