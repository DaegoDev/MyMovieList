//
//  UIFont+Extensions.swift
//  MyMovieList
//

import UIKit

enum FontSize: CGFloat {
  case size10 = 10
  case size12 = 12
  case size14 = 14
  case size16 = 16
  case size18 = 18
}

extension UIFont {
  class func principal(size: FontSize, weight: UIFont.Weight = .regular) -> UIFont {
    return UIFont.systemFont(ofSize: size.rawValue, weight: weight)
  }
  
  class func bold(_ size: FontSize) -> UIFont {
    principal(size: size, weight: .bold)
  }
  
  class func light(_ size: FontSize) -> UIFont {
    principal(size: size, weight: .light)
  }
  
  class func medium(_ size: FontSize) -> UIFont {
    principal(size: size, weight: .medium)
  }
  
  class func regular(_ size: FontSize) -> UIFont {
    principal(size: size, weight: .regular)
  }
  
  class func semibold(_ size: FontSize) -> UIFont {
    principal(size: size, weight: .semibold)
  }
}
