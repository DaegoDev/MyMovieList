//
//  GenreListDataRequest.swift
//  MyMovieList
//

import Foundation

struct GenreListDataRequest: DataRequest {
  typealias Response = GenreListDTO
  var path: String = "/genre/movie/list"
  var method: HTTPMethod = .get
}
