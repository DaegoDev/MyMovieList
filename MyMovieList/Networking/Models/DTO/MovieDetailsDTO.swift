//
//  MovieDetailsDTO.swift
//  MyMovieList
//

import Foundation

struct MovieDetailDTO: Codable {
  let id: Int
  let adult: Bool
  let backdropPath: String
  let budget: Int
  let genres: [GenreDTO]
  let homepage: String?
  let overview: String
  let popularity: Double
  let posterPath: String
  let releaseDate: String
  let revenue: Int
  let runtime: Int?
  let status: String
  let title: String
  let originalTitle: String
  let voteCount: Int
  let voteAverage: Double
  let video: Bool
  let originalLanguage: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case adult
    case backdropPath = "backdrop_path"
    case budget
    case genres
    case homepage
    case overview
    case popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case revenue
    case runtime
    case status
    case title
    case originalTitle = "original_title"
    case voteCount = "vote_count"
    case voteAverage = "vote_average"
    case video
    case originalLanguage = "original_language"
  }
}

extension MovieDetailDTO {
  func toDomain() -> MovieDetail {
    return MovieDetail(
      id: id,
      adult: adult,
      backdropPath: backdropPath,
      budget: budget,
      genres: genres.map { $0.toDomain() },
      homepage: homepage,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      revenue: revenue,
      runtime: runtime,
      status: status,
      title: title,
      originalTitle: originalTitle,
      voteCount: voteCount,
      voteAverage: voteAverage,
      video: video,
      originalLanguage: originalLanguage
    )
  }
}
