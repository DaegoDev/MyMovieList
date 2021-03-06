//
//  Codable+Extensions.swift
//  MyMovieList
//

import Foundation

extension Encodable {
  func toJSONData() -> Data? {
    try? JSONEncoder().encode(self)
  }
}
