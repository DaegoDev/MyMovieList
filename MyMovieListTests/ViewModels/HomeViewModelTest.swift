//
//  HomeViewModelTest.swift
//  MyMovieListTests
//

import XCTest
@testable import MyMovieList

final class HomeViewModelTest: XCTestCase {
  let timeout = 10.0
  
  var movieRepositoryMock: MovieRepositoryMock!
  var genreRepositoryMock: GenreRepositoryMock!
  var homeCoordinatorMock: HomeCoordinatorMock!

  var sut: HomeViewModel!
  
  override func setUp() {
    movieRepositoryMock = MovieRepositoryMock()
    genreRepositoryMock = GenreRepositoryMock()
    homeCoordinatorMock = HomeCoordinatorMock()

    sut = HomeViewModel(
      movieRepository: movieRepositoryMock,
      genreRepository: genreRepositoryMock
    )
    
    sut.coordinator = homeCoordinatorMock
  }
  
  override func tearDown() {
    movieRepositoryMock = nil
    genreRepositoryMock = nil
    sut = nil
    homeCoordinatorMock = nil
  }
  
  func test_fetchMovies() {
    // Given
    let expectation = XCTestExpectation()
    sut.movies.bind { _ in
      expectation.fulfill()
    }
    
    // When
    sut.fetchMovies()
    
    // Then
    wait(for: [expectation], timeout: timeout)
    XCTAssertTrue(movieRepositoryMock.calls.fetchPopularCalled)
    XCTAssertTrue(genreRepositoryMock.calls.fetchGenreListCalled)
    XCTAssertEqual(sut.movies.value?.count, 3)
    XCTAssertEqual(sut.movies.value?.first?.genres.count, 3)
  }
  
  func test_getStoredMovies() {
    // Given
    let expectationGiven = XCTestExpectation()
    sut.movies.bind { _ in
      expectationGiven.fulfill()
    }
    
    sut.fetchMovies()
    
    wait(for: [expectationGiven], timeout: timeout)
    
    // When
    sut.getStoredMovies()
    
    // Then
    guard let firstMovie = sut.movies.value?.first,
          let lastMovie = sut.movies.value?.last
    else {
      XCTFail()
      return
    }
    
    XCTAssertTrue(movieRepositoryMock.calls.fetchStoredMoviesCalled)
    XCTAssertEqual(sut.movies.value?.count, 3)
    XCTAssertTrue(firstMovie.isMovieStored)
    XCTAssertFalse(lastMovie.isMovieStored)
  }
  
  func test_toggleFavoriteMovie_movieIsStored() {
    // Given
    let expectation = XCTestExpectation()
    sut.dataUpdated.bind { _ in
      expectation.fulfill()
    }
    
    sut.fetchMovies()
    wait(for: [expectation], timeout: timeout)

    // When
    sut.toggleFavoriteMovie(at: 0)
    // Then
    guard let firstMovie = sut.movies.value?.first,
          let lastMovie = sut.movies.value?.last
    else {
      XCTFail()
      return
    }
    
    XCTAssertTrue(movieRepositoryMock.calls.deleteStoredMovieCalled)
    XCTAssertFalse(movieRepositoryMock.calls.storeMovieCalled)
    XCTAssertFalse(firstMovie.isMovieStored)
    XCTAssertFalse(lastMovie.isMovieStored)
  }
  
  func test_toggleFavoriteMovie_movieIsNotStored() {
    // Given
    let expectation = XCTestExpectation()
    sut.dataUpdated.bind { _ in
      expectation.fulfill()
    }
    
    sut.fetchMovies()
    wait(for: [expectation], timeout: timeout)
    
    // When
    sut.toggleFavoriteMovie(at: 2)
    // Then
    guard let firstMovie = sut.movies.value?.first,
          let lastMovie = sut.movies.value?.last
    else {
      XCTFail()
      return
    }
    
    XCTAssertFalse(movieRepositoryMock.calls.deleteStoredMovieCalled)
    XCTAssertTrue(movieRepositoryMock.calls.storeMovieCalled)
    XCTAssertTrue(firstMovie.isMovieStored)
    XCTAssertTrue(lastMovie.isMovieStored)
  }
  
  func test_showMovieDetail() {
    // Given
    let expectation = XCTestExpectation()
    sut.movies.bind { _ in
      expectation.fulfill()
    }
    sut.fetchMovies()
    wait(for: [expectation], timeout: timeout)

    // When
    sut.showMovieDetail(at: 0)
    
    // Then
    XCTAssertTrue(homeCoordinatorMock.calls.goToMovieDetailCalled)
  }
}
