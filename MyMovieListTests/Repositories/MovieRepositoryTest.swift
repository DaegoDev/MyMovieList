//
//  MovieRepositoryTest.swift
//  MyMovieListTests
//

import XCTest
@testable import MyMovieList

final class MovieRepositoryTest: XCTestCase {
  private let timeInterval = 10.0
  
  var apiClientMock: APIClientMock!
  var movieDataStorageMock: MovieDataStorage!
  
  var sut: MovieRepository!
  
  override func setUp() {
    super.setUp()
    apiClientMock = APIClientMock()
    movieDataStorageMock = MovieDataStorage(coreDataStorage: CoreDataStorage(persisted: false))
    
    sut = MovieRepository(
      apiClient: apiClientMock,
      movieStorage: movieDataStorageMock
    )
  }
  
  override func tearDown() {
    apiClientMock = nil
    movieDataStorageMock = nil

    sut = nil
    super.tearDown()
  }
  
  func test_fetchPopular_success() {
    // Given
    apiClientMock.responseFile = .moviePopular
    
    // When
    sut.fetchPopular { result in
      // Then
      switch result {
      case .success(let movies):
        XCTAssertEqual(movies.count, 20)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func test_fetchPopular_failure() {
    // Given
    apiClientMock.responseFile = .none
    
    // When
    sut.fetchPopular { result in
      // Then
      switch result {
      case .success:
        XCTFail()
      case .failure(let error):
        XCTAssertNotNil(error)
      }
    }
  }
  
  func test_fetchMovieDetails_success() {
    // Given
    apiClientMock.responseFile = .MovieDetail
    
    // When
    sut.fetchMovieDetails(with: String(MovieMock.movieSpiderMan.id)) { result in
      // Then
      switch result {
      case .success(let movieDetail):
        XCTAssertEqual(movieDetail.id, MovieMock.movieSpiderMan.id)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func test_fetchMovieDetails_failure() {
    // Given
    apiClientMock.responseFile = .none
    
    // When
    sut.fetchMovieDetails(with: String(MovieMock.movieSpiderMan.id)) { result in
      // Then
      switch result {
      case .success:
        XCTFail()
      case .failure(let error):
        XCTAssertNotNil(error)
      }
    }
  }
  
  func test_storeMovie() {
    // Given
    let expectation = XCTestExpectation()
    
    // When
    sut.storeMovie(movie: MovieMock.movieSpiderMan) { result in
      // Then
      switch result {
      case .success(let movie):
        XCTAssertEqual(movie.id, MovieMock.movieSpiderMan.id)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: timeInterval)
  }
  
  func test_fetchStoredMovies() {
    // Given
    let storeExpectation = XCTestExpectation()
    let fetchExpectation = XCTestExpectation()

    sut.storeMovie(movie: MovieMock.movieSpiderMan) { _ in
      storeExpectation.fulfill()
    }
    
    wait(for: [storeExpectation], timeout: timeInterval)

    // When
    sut.fetchStoredMovies { result in
      // Then
      switch result {
      case .success(let movies):
        XCTAssertEqual(movies.count, 1)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      fetchExpectation.fulfill()
    }
    wait(for: [fetchExpectation], timeout: timeInterval)
  }
  
  func test_deleteStoredMovie() {
    // Given
    let expectation = XCTestExpectation()
    
    // When
    sut.deleteStoredMovie(movie: MovieMock.movieSpiderMan) { result in
      // Then
      switch result {
      case .success(let deleted):
        XCTAssertTrue(deleted)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: timeInterval)
  }
}
