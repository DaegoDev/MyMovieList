//
//  MovieDataStorage.swift
//  MyMovieList
//

import Foundation
import CoreData

protocol MovieDataStorageProtocol {
  func fetchMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void)
  func saveMovies(movie: Movie, completion: @escaping (Result<Movie, Error>) -> Void)
  func deleteMovie(movie: Movie, completion: @escaping (Result<Bool, Error>) -> Void)
}

final class MovieDataStorage {
  
  private let coreDataStorage: CoreDataStorage
  
  init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
    self.coreDataStorage = coreDataStorage
  }
}

extension MovieDataStorage: MovieDataStorageProtocol {
  
  func fetchMovies(completion: @escaping (Result<[MovieEntity], Error>) -> Void) {
    coreDataStorage.performBackgroundTask { context in
      do {
        let request: NSFetchRequest = MovieEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(MovieEntity.popularity),
                                                    ascending: false)]
        let result = try context.fetch(request)
        
        completion(.success(result))
      } catch {
        completion(.failure(CoreDataStorageError.readError(error)))
      }
    }
  }
  
  func saveMovies(movie: Movie, completion: @escaping (Result<Movie, Error>) -> Void) {
    coreDataStorage.performBackgroundTask { context in
      do {
        let entity = MovieEntity(movie: movie, insertInto: context)
        try context.save()
        completion(.success(entity.toDomain()))
      } catch {
        completion(.failure(CoreDataStorageError.saveError(error)))
      }
    }
  }
  
  func deleteMovie(movie: Movie, completion: @escaping (Result<Bool, Error>) -> Void) {
    coreDataStorage.performBackgroundTask { context in
      do {
        let request: NSFetchRequest = MovieEntity.fetchRequest()
        let result = try context.fetch(request)
        result.filter { $0.id == movie.id }.forEach { context.delete($0) }
        try context.save()
        completion(.success(true))
      } catch {
        completion(.failure(CoreDataStorageError.saveError(error)))
      }
    }
  }
}
