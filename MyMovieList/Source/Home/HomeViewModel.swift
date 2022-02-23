//
//  HomeViewModel.swift
//  MyMovieList
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
  var coordinator: HomeCoordinatorProtocol? { get set }
  var movies: Observable<[MovieListItemViewModel]> { get }
  var dataUpdated: Observable<Void> { get }

  func fetchMovies()
  func showMovieDetail(at index: Int)
  func toggleFavoriteMovie(at index: Int)
  func getStoredMovies()
}

final class HomeViewModel: HomeViewModelProtocol {
  // MARK: - Inyectables
  weak var coordinator: HomeCoordinatorProtocol?
  
  private var movieRepository: MovieRepositoryProtocol
  private var genreRepository: GenreRepositoryProtocol
  
  // MARK: - Observables
  private(set) var movies = Observable<[MovieListItemViewModel]>()
  var dataUpdated = Observable<Void>()

  // MARK: - init
  init(movieRepository: MovieRepositoryProtocol = MovieRepository(),
       genreRepository: GenreRepositoryProtocol = GenreRepository()
  ) {
    self.movieRepository = movieRepository
    self.genreRepository = genreRepository
  }
  
  // MARK: - Functions
  func fetchMovies() {
    let dispatchGroup = DispatchGroup()
    var movies: [Movie] = []
    var genreListDic: [Int: String] = [:]
    
    dispatchGroup.enter()
    movieRepository.fetchPopular { result in
      if case let .success(responseMovies) = result {
        movies = responseMovies
      }
      dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    genreRepository.fetchGenreList { result in
      if case let .success(responseGenreList) = result {
        responseGenreList.forEach { genre in
          genreListDic[genre.id] = genre.name
        }
      }
      dispatchGroup.leave()
    }
    
    dispatchGroup.notify(queue: .main) { [ weak self] in
      self?.movies.value = movies.compactMap { movie in
        let genreList = genreListDic.compactMap { (id, name) in
          movie.genreIds.contains(id) ? Genre(id: id, name: name) : nil
        }
        return MovieListItemViewModel(movie: movie, genreList: genreList)
      }
      
      self?.getStoredMovies()
    }
  }
  
  func getStoredMovies() {
    movieRepository.fetchStoredMovies { [weak self] result in
      if case let .success(movies) = result {
        let movieIds = movies.map { $0.id }
        self?.movies.value?.forEach({ movieListItemViewModel in
          if movieIds.contains(movieListItemViewModel.movie.id) {
            movieListItemViewModel.isMovieStored = true
          } else {
            movieListItemViewModel.isMovieStored = false
          }
        })
        self?.dataUpdated.fire()
      }
    }
  }
  
  func toggleFavoriteMovie(at index: Int) {
    guard let movieViewModel = movies.value?[index] else { return }
    
    if movieViewModel.isMovieStored {
      movieRepository.deleteStoredMovie(movie: movieViewModel.movie) { result in
        if case let .success(deleted) = result {
          movieViewModel.isMovieStored = !deleted
          self.dataUpdated.fire()
        }
      }
    } else {
      movieRepository.storeMovie(movie: movieViewModel.movie) { _ in
        movieViewModel.isMovieStored = true
        self.dataUpdated.fire()
      }
    }
  }

  func showMovieDetail(at index: Int) {
    guard let movie = movies.value?[index].movie else { return }
    coordinator?.goToMovieDetail(with: movie.id)
  }
}
