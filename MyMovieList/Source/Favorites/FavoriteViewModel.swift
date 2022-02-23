//
//  FavoriteViewModel.swift
//  MyMovieList
//

import Foundation

protocol FavoriteViewModelProtocol {
  var movies: Observable<[MovieListItemViewModel]> { get }
  var dataUpdated: Observable<Void> { get }

  func viewDidLoad()
  func deleteFavorite(at index: Int)
  func showMovieDetail(at index: Int)
}

final class FavoriteViewModel: FavoriteViewModelProtocol {
  // MARK: - Inyectables
  weak var coordinator: FavoriteCoordinatorProtocol?
  
  private var movieRepository: MovieRepositoryProtocol

  // MARK: - Observables
  private(set) var movies = Observable<[MovieListItemViewModel]>()
  var dataUpdated = Observable<Void>()

  // MARK: - Init
  init(movieRepository: MovieRepositoryProtocol = MovieRepository()) {
    self.movieRepository = movieRepository
  }
  
  // MARK: - Functions
  func viewDidLoad() {
    fetchMovies()
  }
  
  func deleteFavorite(at index: Int) {
    guard let movie = movies.value?[index].movie else { return }
    movieRepository.deleteStoredMovie(movie: movie) { [weak self] result in
      if case .success(_) = result {
        self?.movies.value?.remove(at: index)
        self?.dataUpdated.fire()
      }
    }
  }
  
  func showMovieDetail(at index: Int) {
    guard let movie = movies.value?[index].movie else { return }
    coordinator?.goToMovieDetail(with: movie.id)
  }
  
  // MARK: - Helper Functions
  private func fetchMovies() {
    movieRepository.fetchStoredMovies { [weak self] result in
      if case let .success(movies) = result {
        self?.movies.value = movies.map {
          let movieViewModel = MovieListItemViewModel(movie: $0, genreList: [])
          movieViewModel.isMovieStored = true
          return movieViewModel
        }
      }
    }
  }
}
