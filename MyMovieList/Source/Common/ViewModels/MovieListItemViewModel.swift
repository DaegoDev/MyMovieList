//
//  MovieListViewModel.swift
//  MyMovieList
//

import Foundation

final class MovieListItemViewModel {
  private(set) var movie: Movie
  private(set) var genreList: [Genre]
  var isMovieStored: Bool = false
  
  init(movie: Movie, genreList: [Genre]) {
    self.movie = movie
    self.genreList = genreList
  }
}

extension MovieListItemViewModel: InformativeContentCellDataSource {
  var poster: String? {
    movie.posterPath
  }
  
  var title: String {
    movie.title
  }
  
  var overview: String {
    movie.overview
  }
  
  var genres: [String] {
    return genreList.map { $0.name }
  }
  
  var rating: String {
    String("\(Int(movie.voteAverage * 10))%")
  }
  
  var isRecommended: Bool {
    movie.voteAverage >= 6.5
  }
  
  var isActionButtonFilled: Bool {
    isMovieStored
  }
}
