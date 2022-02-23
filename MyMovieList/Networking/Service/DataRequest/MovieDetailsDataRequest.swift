//
//  MovieDetailsDataRequest.swift
//  MyMovieList
//

import Foundation

struct MovieDetailsDataRequest: DataRequest {
  typealias Response = MovieDetailDTO
  let movieId: String
  var method: HTTPMethod = .get
  var path: String {
    return "/movie/\(movieId)"
  }
  
  init(movieId: String) {
    self.movieId = movieId
  }
}
