//
//  MovieDetailViewModel.swift
//  MyMovieList
//

import Foundation

protocol MovieDetailViewModelProtocol {
  var backdropPath: Observable<String> { get set }
  var isFetchingData: Observable<Bool> { get set }

  var title: String { get }
  
  func viewDidLoad()
  func getCastDataSource() -> [PersonViewModel]
  func getMovieDescription() -> String
  func getMovieDetails() -> [[String: String]]
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
  // MARK: - Inyectables
  weak var coordinator: MovieDetailCoordinator?
  
  private var movieRepository: MovieRepositoryProtocol
  private var peopleRepository: PeopleRepositoryProtocol
  
  // MARK: - Properties
  private var movieId: Int
  private var movieDetails: MovieDetail?
  private var castList: [PersonViewModel] = []
  
  var title: String {
    movieDetails?.title ?? ""
  }

  // MARK: - Observables
  var backdropPath = Observable<String>()
  var isFetchingData = Observable<Bool>()
  
  // MARK: - Init
  init(movieId: Int,
       movieRepository: MovieRepositoryProtocol = MovieRepository(),
       peopleRepository: PeopleRepositoryProtocol = PeopleRepository()
  ) {
    self.movieRepository = movieRepository
    self.peopleRepository = peopleRepository
    self.movieId = movieId
  }
  
  // MARK: - Functions
  func viewDidLoad() {
    fetchData()
  }
  
  func fetchData() {
    let dispatchGroup = DispatchGroup()
    
    fetchMovieDetails(dispatchGroup)
    fetchCast(dispatchGroup)
    
    dispatchGroup.notify(queue: .main) { [weak self] in
      self?.isFetchingData.value = false
      self?.backdropPath.value = self?.movieDetails?.backdropPath
    }
  }
  
  func getMovieDescription() -> String {
    return movieDetails?.overview ?? ""
  }
  
  func getMovieDetails() -> [[String: String]] {
    guard let movieDetails = movieDetails else {
      return []
    }
    
    var details = [[String: String]]()
    
    details.append([Strings.voteAverague: "\(movieDetails.voteAverage)"])
    details.append([Strings.budget: "\(movieDetails.budget)".toCurrencyFormat()])
    details.append([Strings.revenue: "\(movieDetails.revenue)".toCurrencyFormat()])
    details.append([Strings.releaseDate: "\(movieDetails.releaseDate)".toDateFormat()])
    details.append([Strings.status: "\(movieDetails.status)"])
    details.append([Strings.language: "\(movieDetails.originalLanguage)"])
    
    return details
  }
  
  func getCastDataSource() -> [PersonViewModel] {
    return castList
  }
  
  // MARK: - Helper Functions
  private func fetchMovieDetails(_ group: DispatchGroup) {
    group.enter()
    movieRepository.fetchMovieDetails(with: "\(movieId)") { [weak self] result in
      if case let .success(movieDetails) = result {
        self?.movieDetails = movieDetails
      }
      group.leave()
    }
  }

  private func fetchCast(_ group: DispatchGroup) {
    group.enter()
    peopleRepository.fetchCast(with: "\(movieId)") { [weak self] result in
      if case let .success(cast) = result {
        self?.castList = cast.map { PersonViewModel(character: $0) }
      }
      group.leave()
    }
  }
}
