//
//  MovieDTO.swift
//  MyMovieList
//

import Foundation

struct MovieDTO: Codable {
  let id: Int
  let adult: Bool
  let genreIds: [Int]
  let title: String
  let originalTitle: String
  let overview: String
  let popularity: Double
  let voteCount: Int
  let voteAverage: Double
  let posterPath: String
  let backdropPath: String
  let releaseDate: String
  let video: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case adult
    case genreIds = "genre_ids"
    case title
    case originalTitle = "original_title"
    case overview
    case popularity
    case voteCount = "vote_count"
    case voteAverage = "vote_average"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case video
  }
}

extension MovieDTO {
  func toDomain() -> Movie {
    return Movie(
      id: id,
      adult: adult,
      genreIds: genreIds,
      title: title,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      voteCount: voteCount,
      voteAverage: voteAverage,
      posterPath: posterPath,
      backdropPath: backdropPath,
      releaseDate: releaseDate,
      video: video)
  }
}
