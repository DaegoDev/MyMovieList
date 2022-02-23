//
//  UIConstants.swift
//  MyMovieList
//

import UIKit

struct UIConstants {
  
  static let defaultSpacing: CGFloat = 16
  static let defaultItemSpacing: CGFloat = 8
  static let smallSpacing: CGFloat = 4
  
  static let defaultCornerRadius: CGFloat = 8
  
  struct Home {
    static let insets = UIEdgeInsets(top: 0, left: 0, bottom: 52, right: 0)
  }
  
  struct MovieDetail {
    static let insets = UIEdgeInsets(top: 0, left: 0, bottom: 52, right: 0)
  }
  
  struct Favorites {
    static let insets = UIEdgeInsets(top: 0, left: 0, bottom: 52, right: 0)
  }
  
  struct PillView {
  }
  
  // MARK: - Cells
  struct SegmenteControlTableViewCell {
    static let height: CGFloat = 50
  }
  
  struct BackdropTableViewCell {
    static let backdropHeight: CGFloat = 280
  }
  
  struct DetailListTableViewCell {
    static let columnCount: Int = 3
  }
  
  struct InformativeContentCollectionViewCell {
    static let titleLineCount: Int = 2
    static let cardInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    static let posterRatio: CGFloat = 3
    static let titleInsetConstant: CGFloat = 8
    static let ratingImageInsetConstant: CGFloat = 8
    static let ratingImageSize: CGFloat = 16
    static let ratingLabelInsetConstant: CGFloat = 8
    static let descriptionLabelInsetConstant: CGFloat = 8
    static let footerInsetConstant: CGFloat = 8
    static let footerHeight: CGFloat = 40
    static let pillViewInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 4)
    static let actionButtonInsetconstant: CGFloat = 8
    static let actionButtonSize: CGFloat = 28
  }
  
  struct PersonCollectionViewCell {
    static let containerHeight: CGFloat = 300
    static let personLabelsLineCount: Int = 2
    static let profileWidht: CGFloat = 150
    static let profileHeight: CGFloat = 200
  }
}
