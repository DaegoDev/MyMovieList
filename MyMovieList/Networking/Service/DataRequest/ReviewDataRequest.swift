//
//  ReviewDataRequest.swift
//  MyMovieList
//

import Foundation

struct ReviewDataRequest: DataRequest {
  typealias Response = PagingDTO<[ReviewDTO]>
  let movieId: String
  var method: HTTPMethod = .get
  var path: String {
    return "/movie/\(movieId)/reviews"
  }
  
  init(movieId: String) {
    self.movieId = movieId
  }
}
