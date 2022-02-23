//
//  MovieDataRequest.swift
//  MyMovieList
//

import Foundation

struct MoviePopularDataRequest: DataRequest {
  typealias Response = PagingDTO<[MovieDTO]>
  var path: String = "/movie/popular"
  var method: HTTPMethod = .post
}
