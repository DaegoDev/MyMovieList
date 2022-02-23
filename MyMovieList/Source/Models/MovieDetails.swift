//
//  MovieDetails.swift
//  MyMovieList
//

import Foundation

struct MovieDetail {
  let id: Int
  let adult: Bool
  let backdropPath: String
  let budget: Int
  let genres: [Genre]
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
}
