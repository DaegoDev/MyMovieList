//
//  DecriptionCollectionViewCell.swift
//  MyMovieList
//

import UIKit

final class DescriptionTableViewCell: UITableViewCell {
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.roundCorners()
    return view
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .regular(.size18)
    label.numberOfLines = .zero
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .vertical)

    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addViews()
    backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  func setDescription(_ text: String) {
    descriptionLabel.text = text
  }
  
  private func addViews() {
    containerView.addSubview(descriptionLabel)
    contentView.addSubview(containerView)
    
    containerView.insetsToSuperview(constant: UIConstants.defaultSpacing)
    descriptionLabel.insetsToSuperview(constant: UIConstants.defaultSpacing)
    
    containerView.setShadowBorder()
  }
}

