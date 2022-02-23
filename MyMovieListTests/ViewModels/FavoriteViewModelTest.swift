//
//  FavoriteViewModelTest.swift
//  MyMovieListTests
//

import XCTest
@testable import MyMovieList

final class FavoriteViewModelTest: XCTestCase {

  let timeout = 10.0
  
  var movieRepositoryMock: MovieRepositoryMock!
  var favoriteCoordinatorMock: FavoriteCoordinatorMock!
  
  var sut: FavoriteViewModel!
  
  override func setUp() {
    super.setUp()
    movieRepositoryMock = MovieRepositoryMock()
    favoriteCoordinatorMock = FavoriteCoordinatorMock()
    
    sut = FavoriteViewModel(
      movieRepository: movieRepositoryMock
    )
    
    sut.coordinator = favoriteCoordinatorMock
  }
  
  override func tearDown() {
    movieRepositoryMock = nil
    favoriteCoordinatorMock = nil
    sut = nil
    super.tearDown()
  }
  
  func test_viewDidLoad() {
    // Given
    let expectation = XCTestExpectation()
    sut.movies.bind { _ in
      expectation.fulfill()
    }
    // When
    sut.viewDidLoad()
    
    // Then
    wait(for: [expectation], timeout: timeout)
    XCTAssertTrue(movieRepositoryMock.calls.fetchStoredMoviesCalled)
    XCTAssertEqual(sut.movies.value?.count, 1)
  }
  
  func test_deleteFavorite() {
    // Given
    let expectation = XCTestExpectation()
    sut.movies.bind { _ in
      expectation.fulfill()
    }
    
    sut.viewDidLoad()
    wait(for: [expectation], timeout: timeout)
    
    // When
    sut.deleteFavorite(at: 0)
    // Then

    XCTAssertTrue(movieRepositoryMock.calls.deleteStoredMovieCalled)
    XCTAssertEqual(sut.movies.value?.count, 0)
  }
  
  func test_showMovieDetail() {
    // Given
    let expectation = XCTestExpectation()
    sut.movies.bind { _ in
      expectation.fulfill()
    }
    sut.viewDidLoad()
    wait(for: [expectation], timeout: timeout)
    
    // When
    sut.showMovieDetail(at: 0)
    
    // Then
    XCTAssertTrue(favoriteCoordinatorMock.calls.goToMovieDetailCalled)
  }
}
