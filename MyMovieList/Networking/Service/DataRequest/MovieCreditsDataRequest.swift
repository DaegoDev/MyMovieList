//
//  MovieCreditsDataRequest.swift
//  MyMovieList
//

import Foundation

struct MovieCreditsDataRequest: DataRequest {
  typealias Response = MovieCreditsDTO
  let movieId: String
  var method: HTTPMethod = .get
  var path: String {
    return "/movie/\(movieId)/credits"
  }
  
  init(movieId: String) {
    self.movieId = movieId
  }
}
