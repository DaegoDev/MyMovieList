//
//  ImageDataRequest.swift
//  MyMovieList
//

import Foundation

struct ImageDataRequest: DataRequest {
  typealias Response = Data
  var method: HTTPMethod = .get
  var path: String
  
  init(path: String) {
    self.path = path
  }
  
  func decode(_ data: Data) throws -> Response {
    return data
  }
}
