//
//  MovieCreditsDTO.swift
//  MyMovieList
//

import Foundation

struct MovieCreditsDTO: Codable {
  let id: Int
  let cast: [PersonDTO]
}
