//
//  GenreRepositoryTest.swift
//  MyMovieListTests
//

import XCTest
@testable import MyMovieList

final class GenreRepositoryTest: XCTestCase {
  private let timeInterval = 10.0
  
  var apiClientMock: APIClientMock!
  var sut: GenreRepository!
  
  override func setUp() {
    super.setUp()
    apiClientMock = APIClientMock()
    sut = GenreRepository(apiClient: apiClientMock)
  }
  
  override func tearDown() {
    apiClientMock = nil
    sut = nil
    super.tearDown()
  }
  
  func test_fetchGenreList_success() {
    // Given
    apiClientMock.responseFile = .genreList
    
    // When
    sut.fetchGenreList { result in
      // Then
      switch result {
      case .success(let movies):
        XCTAssertEqual(movies.count, 19)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func test_fetchGenreList_failure() {
    // Given
    apiClientMock.responseFile = .none
    
    // When
    sut.fetchGenreList { result in
      // Then
      switch result {
      case .success:
        XCTFail()
      case .failure(let error):
        XCTAssertNotNil(error)
      }
    }
  }
}
