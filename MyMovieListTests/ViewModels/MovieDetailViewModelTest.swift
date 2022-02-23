//
//  MovieDetailViewModelTest.swift
//  MyMovieListTests
//

import XCTest
@testable import MyMovieList

final class MovieDetailViewModelTest: XCTestCase {
  let timeout = 10.0
  
  var movieRepositoryMock: MovieRepositoryMock!
  var peopleRepositoryMock: PeopleRepositoryMock!
  
  var sut: MovieDetailViewModel!
  
  override func setUp() {
    movieRepositoryMock = MovieRepositoryMock()
    peopleRepositoryMock = PeopleRepositoryMock()
    
    sut = MovieDetailViewModel(
      movieId: MovieMock.movieSpiderMan.id,
      movieRepository: movieRepositoryMock,
      peopleRepository: peopleRepositoryMock
    )
  }
  
  override func tearDown() {
    movieRepositoryMock = nil
    peopleRepositoryMock = nil
    sut = nil
  }
  
  func test_viewDidLoad() {
    // Given
    let expectation = XCTestExpectation()
    sut.isFetchingData.bind { _ in
      expectation.fulfill()
    }
    
    // When
    sut.viewDidLoad()
    
    // Then
    wait(for: [expectation], timeout: timeout)
    XCTAssertTrue(movieRepositoryMock.calls.fetchMovieDetailsCalled)
    XCTAssertTrue(peopleRepositoryMock.calls.fetchCastCalled)
    XCTAssertEqual(sut.getCastDataSource().count, PersonMock.allPeople.count)
  }
  
  func test_title() {
    // Given
    let expectation = XCTestExpectation()
    sut.isFetchingData.bind { _ in
      expectation.fulfill()
    }
    sut.viewDidLoad()
    wait(for: [expectation], timeout: timeout)
    // When
    let title = sut.title
    
    // Then
    XCTAssertEqual(title, "Spider-Man: No Way Home")
  }
  
  func test_getMovieDescription() {
    // Given
    let expectation = XCTestExpectation()
    sut.isFetchingData.bind { _ in
      expectation.fulfill()
    }
    sut.viewDidLoad()
    wait(for: [expectation], timeout: timeout)
    // When
    let description = sut.getMovieDescription()
    
    // Then
    XCTAssertTrue(!description.isEmpty)
  }
  
  func test_getMovieDetails() {
    // Given
    let expectation = XCTestExpectation()
    sut.isFetchingData.bind { _ in
      expectation.fulfill()
    }
    sut.viewDidLoad()
    wait(for: [expectation], timeout: timeout)
    // When
    let movieDetails = sut.getMovieDetails()
    
    // Then
    XCTAssertEqual(movieDetails[0]["Vote Average"], "8.3")
    XCTAssertEqual(movieDetails[1]["Budget"], "$200,000,000")
    XCTAssertEqual(movieDetails[2]["Revenue"], "$1,809,940,686")
    XCTAssertEqual(movieDetails[3]["Release Date"], "15 Jan, 2021")
    XCTAssertEqual(movieDetails[4]["Status"], "Released")
    XCTAssertEqual(movieDetails[5]["Language"], "en")

  }
}
