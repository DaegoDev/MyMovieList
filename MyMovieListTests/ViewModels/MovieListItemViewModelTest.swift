//
//  MovieListItemViewModelTest.swift
//  MyMovieListTests
//

import XCTest
@testable import MyMovieList

final class MovieListItemViewModelTest: XCTestCase {
  var sut: MovieListItemViewModel!
  
  override func setUp() {
    super.setUp()
    sut = MovieListItemViewModel(
      movie: MovieMock.movieSpiderMan,
      genreList: GenreMock.allGenres
    )
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_MovieDataSource() {
    // When
    let poster = sut.poster
    let title = sut.title
    let overview = sut.overview
    let genres = sut.genres
    let rating = sut.rating
    let isRecommended = sut.isRecommended
    let isActionButtonFilled = sut.isActionButtonFilled

    
    // Then
    XCTAssertEqual(poster, "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
    XCTAssertEqual(title, "Spider-Man: No Way Home")
    XCTAssertFalse(overview.isEmpty)
    XCTAssertEqual(genres.count, 14)
    XCTAssertEqual(rating, "83%")
    XCTAssertTrue(isRecommended)
    XCTAssertFalse(isActionButtonFilled)

  }
}
