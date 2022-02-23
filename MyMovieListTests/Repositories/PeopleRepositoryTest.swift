//
//  PeopleRepositoryTest.swift
//  MyMovieListTests
//

import XCTest
@testable import MyMovieList

final class PeopleRepositoryTest: XCTestCase {
  private let timeInterval = 10.0
  
  var apiClientMock: APIClientMock!
  var sut: PeopleRepository!
  
  override func setUp() {
    super.setUp()
    apiClientMock = APIClientMock()
    sut = PeopleRepository(apiClient: apiClientMock)
  }
  
  override func tearDown() {
    apiClientMock = nil
    sut = nil
    super.tearDown()
  }
  
  func test_fetchCast_success() {
    // Given
    apiClientMock.responseFile = .credits
    
    // When
    sut.fetchCast(with: String(MovieMock.movieSpiderMan.id)) { result in
      // Then
      switch result {
      case .success(let movies):
        XCTAssertEqual(movies.count, 59)
      case .failure(let error):
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func test_fetchCast_failure() {
    // Given
    apiClientMock.responseFile = .none
    
    // When
    sut.fetchCast(with: String(MovieMock.movieSpiderMan.id)) { result in
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
