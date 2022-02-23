//
//  Dictionary+Extensions.swift
//  MyMovieList
//

import Foundation

func + <K, V> (left: [K: V], right: [K: V]) -> [K: V] {
  var merge = left
  for (key, value) in right {
    merge[key] = value
  }
  return merge
}
