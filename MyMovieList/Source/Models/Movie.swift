//
//  Movie.swift
//  MyMovieList
//

import Foundation

struct Movie {
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
}

