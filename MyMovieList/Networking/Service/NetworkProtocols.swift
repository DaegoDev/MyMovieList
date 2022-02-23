//
//  NetworkProtocols.swift
//  MyMovieList
//

import Foundation

protocol ServiceConfiguration {
  var url: String { get }
  var headers: [String: String] { get }
  var queryItems: [String: String] { get }
  var body: Data? { get }
}

protocol NetworkService {
  func request<Request: DataRequest>(
    _ request: Request,
    completion: @escaping(Result<Request.Response, Error>) -> Void
  )
}
