//
//  UIImageView+Extensions.swift
//  MyMovieList
//

import UIKit

extension UIImageView {
  
  func loadImage(with path: String) {
    ImageRepository().fetchImage(path: path) { [weak self] result in
      if case let .success(data) = result {
        self?.image = UIImage(data: data)
      }
    }
  }
}

