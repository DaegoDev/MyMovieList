//
//  MovieDetailMock.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

struct MovieDetailMock {
  static var spidermanDetails = MovieDetail(
    id: 634649,
    adult: false,
    backdropPath: "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
    budget: 200000000,
    genres: [
      Genre(id: 28, name: "Action"),
      Genre(id: 12, name: "Adventure"),
      Genre(id: 878, name: "Science Fiction")
    ],
    homepage: "https://www.spidermannowayhome.movie",
    overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
    popularity: 6865.258,
    posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
    releaseDate: "2021-12-15",
    revenue: 1809940686,
    runtime: 148,
    status: "Released",
    title: "Spider-Man: No Way Home",
    originalTitle: "Spider-Man: No Way Home",
    voteCount: 8238,
    voteAverage: 8.3,
    video: false,
    originalLanguage: "en"
  )
}
