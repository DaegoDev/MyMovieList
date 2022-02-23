//
//  ReviewCollectionViewCell.swift
//  MyMovieList
//

import UIKit

protocol PersonCellDataSource: TrailableDataSource  {
  var profilePath: String { get }
  var name: String { get }
  var characterName: String { get }
}

extension PersonCellDataSource {
  var cellType: TrailableCollectionViewCell.Type {
    PersonCollectionViewCell.self
  }
}

final class PersonCollectionViewCell: UICollectionViewCell, TrailableCollectionViewCell {
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.roundCorners()
    view.setShadowBorder()
    return view
  }()
    
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.font = .bold(.size16)
    label.numberOfLines = UIConstants.PersonCollectionViewCell.personLabelsLineCount
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    
    return label
  }()
  
  private lazy var characterLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = UIConstants.PersonCollectionViewCell.personLabelsLineCount
    label.font = .semibold(.size12)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    label.setContentHuggingPriority(.required, for: .vertical)
    
    return label
  }()
  
  private lazy var profile = UIImageView()

  
  var dataSource: TrailableDataSource? {
    didSet {
      setup()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    profile.image = nil
    nameLabel.text = ""
    characterLabel.text = ""
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  private func setup() {
    guard let dataSource = dataSource as? PersonCellDataSource else { return }
    profile.loadImage(with: dataSource.profilePath)
    nameLabel.text = dataSource.name
    characterLabel.text = dataSource.characterName
  }
  
  private func addViews() {
    containerView.addSubview(profile)
    containerView.addSubview(nameLabel)
    containerView.addSubview(characterLabel)
    contentView.addSubview(containerView)
    
    containerView.insetsToSuperview(constant: UIConstants.defaultItemSpacing)
    containerView.setHeightConstraint(UIConstants.PersonCollectionViewCell.containerHeight)
    
    profile.insetsTo(
      topAnchor: containerView.topAnchor,
      leadingAnchor: containerView.leadingAnchor,
      trailingAnchor: containerView.trailingAnchor
    )
    
    profile.setWidthConstraint(UIConstants.PersonCollectionViewCell.profileWidht)
    profile.setHeightConstraint(UIConstants.PersonCollectionViewCell.profileHeight)
    
    nameLabel.insetsTo(
      topAnchor: profile.bottomAnchor,
      leadingAnchor: containerView.leadingAnchor,
      trailingAnchor: containerView.trailingAnchor,
      constant: UIConstants.defaultItemSpacing
    )

    characterLabel.insetsTo(
      topAnchor: nameLabel.bottomAnchor,
      leadingAnchor: containerView.leadingAnchor,
      trailingAnchor: containerView.trailingAnchor,
      constant: UIConstants.defaultItemSpacing
    )
    
    characterLabel.insetsLessThanOrEqualsTo(
      bottomAnchor: containerView.bottomAnchor,
      constant: UIConstants.defaultItemSpacing)
  }
}
