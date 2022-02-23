//
//  PillViewCollectionViewCell.swift
//  MyMovieList
//

import UIKit

final class PillViewCollectionViewCell: UICollectionViewCell {
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .cyan
    view.roundCorners()
    return view
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .bold(.size12)
    label.textAlignment = .center
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  func setPillText(_ text: String, with color: UIColor) {
    titleLabel.text = text
  }
  
  private func setupUI() {
    backgroundColor = .clear
    addViews()
  }
  
  private func addViews() {
    containerView.addSubview(titleLabel)
    addSubview(containerView)
    
    containerView.insetsToSuperview()
    titleLabel.insetsToSuperview(constant: UIConstants.smallSpacing)
  }
}
