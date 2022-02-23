//
//  GenreDTO.swift
//  MyMovieList
//

import Foundation

struct GenreDTO: Codable {
  let id: Int
  let name: String
}

extension GenreDTO {
  func toDomain() -> Genre {
    return Genre(id: id, name: name)
  }
}
