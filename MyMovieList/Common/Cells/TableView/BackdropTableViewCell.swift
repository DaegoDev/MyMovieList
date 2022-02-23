//
//  MovieDetailBackdropTableViewCell.swift
//  MyMovieList
//

import UIKit

final class BackdropTableViewCell: UITableViewCell {
  private lazy var backdropImageView: UIImageView = {
    let imageView = UIImageView()
    
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  func setBackdropImage(with path: String?) {
    guard let path = path else { return }
    self.backdropImageView.loadImage(with: path)
  }
  
  private func addViews() {
    addSubview(backdropImageView)
    backdropImageView.insetsToSuperview()
    backdropImageView.setHeightConstraint(UIConstants.BackdropTableViewCell.backdropHeight)
  }
}
