//
//  PeopleViewModel.swift
//  MyMovieList
//

import Foundation

struct PersonViewModel {
  private(set) var character: Person
  
  init(character: Person) {
    self.character = character
  }
}

extension PersonViewModel: PersonCellDataSource {
  var profilePath: String {
    character.profilePath ?? ""
  }
  
  var name: String {
    character.originalName
  }
  
  var characterName: String {
    character.character
  }
}
