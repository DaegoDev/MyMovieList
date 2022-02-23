//
//  PagingDTO.swift
//  MyMovieList
//

import Foundation

struct PagingDTO<T: Codable>: Codable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let results: T

  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case results
  }
}
