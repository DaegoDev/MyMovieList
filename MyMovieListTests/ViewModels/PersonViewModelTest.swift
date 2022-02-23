//
//  PersonViewModelTest.swift
//  MyMovieListTests
//

import XCTest
@testable import MyMovieList

final class PersonViewModelTest: XCTestCase {
  
  var sut: PersonViewModel!
  
  override func setUp() {
    super.setUp()
    sut = PersonViewModel(character: PersonMock.tomHolland)
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func test_PersonDataSource() {
    // When
    let profilePath = sut.profilePath
    let name = sut.name
    let characterName = sut.characterName
    
    // Then
    XCTAssertEqual(profilePath, "/2qhIDp44cAqP2clOgt2afQI07X8.jpg")
    XCTAssertEqual(name, "Tom Holland")
    XCTAssertEqual(characterName, "Peter Parker / Spider-Man")
  }
}
