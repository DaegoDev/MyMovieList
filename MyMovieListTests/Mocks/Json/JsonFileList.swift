//
//  JsonFileList.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

enum JsonFileList: String {
  case credits = "CreditsSuccess"
  case genreList = "GenreListSuccess"
  case MovieDetail = "MovieDetailSuccess"
  case moviePopular = "MoviePopularSuccess"
  case none
  
  var fileName: String {
    return self.rawValue
  }
}
