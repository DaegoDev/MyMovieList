//
//  DefaultServiceConfiguration.swift
//  MyMovieList
//

import Foundation

struct DefaultServiceConfiguration: ServiceConfiguration {
  var url: String = AppConstants.API.baseUrl
  var headers: [String : String]  = [:]
  var body: Data? = nil
  
  var queryItems: [String : String] {
    [HTTPHeader.apiKey.rawValue: AppConstants.API.apiKey]
  }
}
