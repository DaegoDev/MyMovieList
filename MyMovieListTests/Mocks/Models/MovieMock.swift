//
//  MovieMock.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

struct MovieMock {
  static var movieSpiderMan = Movie(
    id: 634649,
    adult: false,
    genreIds: [28, 12, 878],
    title: "Spider-Man: No Way Home",
    originalTitle: "Spider-Man: No Way Home",
    overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
    popularity: 8463.919,
    voteCount: 8153,
    voteAverage: 8.3,
    posterPath: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
    backdropPath: "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
    releaseDate: "2021-12-15",
    video: false
  )
  
  static var movieKingsMan = Movie(
    id: 476669,
    adult: false,
    genreIds: [28, 12, 53, 10752],
    title: "The King's Man",
    originalTitle: "The King's Man",
    overview: "As a collection of history's worst tyrants and criminal masterminds gather to plot a war to wipe out millions, one man must race against time to stop them.",
    popularity: 5069.377,
    voteCount: 1208,
    voteAverage: 7.1,
    posterPath: "/aq4Pwv5Xeuvj6HZKtxyd23e6bE9.jpg",
    backdropPath: "/4OTYefcAlaShn6TGVK33UxLW9R7.jpg",
    releaseDate: "2021-12-15",
    video: false
  )
  
  static var movieEternals = Movie(
    id: 524434,
    adult: false,
    genreIds: [28, 12, 14, 878],
    title: "Eternals",
    originalTitle: "Eternals",
    overview: "The Eternals are a team of ancient aliens who have been living on Earth in secret for thousands of years. When an unexpected tragedy forces them out of the shadows, they are forced to reunite against mankind’s most ancient enemy, the Deviants.",
    popularity: 2562.22,
    voteCount: 4453,
    voteAverage: 7.2,
    posterPath: "/bcCBq9N1EMo3daNIjWJ8kYvrQm6.jpg",
    backdropPath: "/c6H7Z4u73ir3cIoCteuhJh7UCAR.jpg",
    releaseDate: "2021-12-15",
    video: false
  )
}
