//
//  MovieDetailViewController.swift
//  MyMovieList
//

import CoreData

enum CoreDataStorageError: Error {
  case readError(Error)
  case saveError(Error)
  case deleteError(Error)
}

final class CoreDataStorage {
  static let shared = CoreDataStorage()
  
  var persisted: Bool
  
  init(persisted: Bool = true) {
    self.persisted = persisted
  }
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let description = NSPersistentStoreDescription()
    
    if persisted {
      description.type = NSSQLiteStoreType
      var directoryURL = NSPersistentContainer.defaultDirectoryURL()
      description.url = directoryURL.appendingPathComponent("Movie.sqlite")
    } else {
      description.type = NSInMemoryStoreType
    }
    
    let container = NSPersistentContainer(name: "MyMovieList")
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
      }
    }
  }
  
  func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
    persistentContainer.performBackgroundTask(block)
  }
}
