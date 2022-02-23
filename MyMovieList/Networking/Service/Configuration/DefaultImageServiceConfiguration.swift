//
//  File.swift
//  MyMovieList
//

import Foundation

struct DefaultImageServiceConfiguration: ServiceConfiguration {
  var url: String = AppConstants.API.baseImageUrl
  var headers: [String : String]  = [:]
  var body: Data? = nil
  
  var queryItems: [String : String] {
    [HTTPHeader.apiKey.rawValue: AppConstants.API.apiKey]
  }
}
