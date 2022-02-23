//
//  UICollectionView+Extensions.swift
//  MyMovieList
//

import Foundation
import UIKit

extension UICollectionView {
  func register<T: UICollectionViewCell>(with cellType: T.Type) {
    register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
  }
  
  func dequeueReusableCell<T: UICollectionViewCell>(
    with cellType: T.Type,
    for indexPath: IndexPath
  ) -> T? {
    return dequeueReusableCell(
      withReuseIdentifier: cellType.reuseIdentifier,
      for: indexPath) as? T
    
  }
}
