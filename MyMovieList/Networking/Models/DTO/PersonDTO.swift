//
//  PeopleDTO.swift
//  MyMovieList
//

import Foundation

struct PersonDTO: Codable {
  let id: Int
  let adult: Bool
  let gender: Int
  let knownForDepartment: String
  let name: String
  let originalName: String
  let popularity: Double
  let profilePath: String?
  let castId: Int
  let character: String
  let creditId: String
  let order: Int
  
  enum CodingKeys: String, CodingKey {
    case id
    case adult
    case gender
    case knownForDepartment = "known_for_department"
    case name
    case originalName = "original_name"
    case popularity
    case profilePath = "profile_path"
    case castId = "cast_id"
    case character
    case creditId = "credit_id"
    case order
  }
}

extension PersonDTO {
  func toDomain() -> Person {
    return Person(
      id: id,
      adult: adult,
      gender: gender,
      knownForDepartment: knownForDepartment,
      name: name,
      originalName: originalName,
      popularity: popularity,
      profilePath: profilePath,
      castId: castId,
      character: character,
      creditId: creditId,
      order: order)
  }
}
