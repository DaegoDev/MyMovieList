//
//  PersonMock.swift
//  MyMovieListTests
//

import Foundation
@testable import MyMovieList

struct PersonMock {
  static var allPeople = [
    tomHolland, zendaya, jacobBatalon
  ]
  
  static var tomHolland = Person(
    id: 1136406,
    adult: false,
    gender: 2,
    knownForDepartment: "Acting",
    name: "Tom Holland",
    originalName: "Tom Holland",
    popularity: 117.834,
    profilePath: "/2qhIDp44cAqP2clOgt2afQI07X8.jpg",
    castId: 1,
    character: "Peter Parker / Spider-Man",
    creditId: "5d8e28d38289a0000fcc32f9",
    order: 0
  )
  
  static var zendaya = Person(
    id: 505710,
    adult: false,
    gender: 1,
    knownForDepartment: "Acting",
    name: "Zendaya",
    originalName: "Zendaya",
    popularity: 69.293,
    profilePath: "/so3GqzuvXbYkNzQYNliAMB5rZzT.jpg",
    castId: 54,
    character: "Michelle 'MJ' Jones",
    creditId: "5fd968c09408ec003cdd0557",
    order: 1
  )
  
  static var jacobBatalon = Person(
    id: 1649152,
    adult: false,
    gender: 2,
    knownForDepartment: "Acting",
    name: "Jacob Batalon",
    originalName: "Jacob Batalon",
    popularity: 26.688,
    profilePath: "/53YhaL4xw4Sb1ssoHkeSSBaO29c.jpg",
    castId: 69,
    character: "Ned Leeds",
    creditId: "6124200e4a52f8005dd04318",
    order: 2
  )
}
