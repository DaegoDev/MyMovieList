//
//  MovieEntity+Mapping.swift
//  MyMovieList
//

import Foundation
import CoreData

extension MovieEntity {
  convenience init(movie: Movie, insertInto context: NSManagedObjectContext) {
    self.init(context: context)
    self.id = Int32(movie.id)
    self.adult = movie.adult
    self.genreIds = movie.genreIds
    self.title = movie.title
    self.originalTitle = movie.originalTitle
    self.overview = movie.overview
    self.popularity = movie.popularity
    self.voteCount = Int16(movie.voteCount)
    self.voteAverage = movie.voteAverage
    self.posterPath = movie.posterPath
    self.backdropPath = movie.backdropPath
    self.releaseDate = movie.releaseDate
    self.video = movie.video
  }
}

extension MovieEntity {
  func toDomain() -> Movie {
    return Movie(
      id: Int(id),
      adult: adult,
      genreIds: genreIds ?? [],
      title: title ?? "",
      originalTitle: originalTitle ?? "",
      overview: overview ?? "",
      popularity: popularity,
      voteCount: Int(voteCount),
      voteAverage: voteAverage,
      posterPath: posterPath ?? "",
      backdropPath: backdropPath ?? "",
      releaseDate: releaseDate ?? "",
      video: video
    )
  }
}
