//
//  Observable.swift
//  MyMovieList
//

import Foundation

final class Observable<T> {
  typealias Listener = (T?) -> ()
  var listener: Listener?
  
  func bind(_ listener: Listener?) {
    self.listener = listener
  }
  
  func bindAndFire(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
  
  func fire() {
    listener?(value)
  }
  
  var value: T? {
    didSet {
      listener?(value)
    }
  }
}
