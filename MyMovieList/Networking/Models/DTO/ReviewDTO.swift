//
//  ReviewDTO.swift
//  MyMovieList
//

import Foundation

struct ReviewDTO: Codable {
  let id: String
  let author: String
  let content: String
  let createdAt: String
  let updatedAt: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case author
    case content
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case url
  }
}

extension ReviewDTO {
  func toDomain() -> Review {
    return Review(
      id: id,
      author: author,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      url: url
    )
  }
}
