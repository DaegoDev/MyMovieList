//
//  InformativeContentCollectionViewCell.swift
//  MyMovieList
//

import UIKit

protocol InformativeContentCellDataSource {
  var poster: String? { get }
  var title: String { get }
  var overview: String { get }
  var genres: [String] { get }
  var rating: String { get }
  var isRecommended: Bool { get }
  var isActionButtonFilled: Bool { get }
}

final class InformativeContentCollectionViewCell: UICollectionViewCell {
  private lazy var cardView: UIView = {
    let view = UIView()
    view.roundCorners()
    view.backgroundColor = .white
    return view
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.setContentHuggingPriority(.required, for: .vertical)
    label.font = .bold(.size16)
    label.textAlignment = .center
    label.numberOfLines = UIConstants.InformativeContentCollectionViewCell.titleLineCount
    return label
  }()
  
  private lazy var ratingLabel: UILabel = {
    let label = UILabel()
    label.font = .semibold(.size12)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    label.setContentHuggingPriority(.required, for: .horizontal)
    return label
  }()
  
  private lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .regular(.size12)
    label.numberOfLines = .zero
    label.textAlignment = .natural
    label.setContentHuggingPriority(.defaultHigh, for: .vertical)
    label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    return label
  }()
  
  private lazy var actionButton: UIButton = {
    let button = UIButton()
    button.tintColor = .systemBlue
    button.addTarget(self, action: #selector(onActionButtonPressed), for: .touchUpInside)
    return button
  }()
  
  private lazy var poster = UIImageView()
  private lazy var ratingImageView = UIImageView()
  private lazy var pillView = PillView()
  
  var dataSource: InformativeContentCellDataSource? {
    didSet {
      setupCell()
    }
  }
  
  var actionButtonPressed: (() -> Void)?
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    poster.image = nil    
  }
  
  @objc private func onActionButtonPressed() {
    actionButtonPressed?()
  }
  
  private func setupCell() {
    guard let dataSource = dataSource else {
      return
    }
    
    poster.loadImage(with: dataSource.poster ?? "")
    titleLabel.text = dataSource.title
    ratingLabel.text = dataSource.rating
    descriptionLabel.text = dataSource.overview
    pillView.setPills(dataSource.genres)
    ratingImageView.image = dataSource.isRecommended
      ? UIImage(systemName: "hand.thumbsup.fill")
      : UIImage(systemName: "hand.thumbsdown.fill")
    ratingImageView.tintColor = dataSource.isRecommended
    ? .successColor
    : .dangerColor
    
    actionButton.setBackgroundImage(
      dataSource.isActionButtonFilled
      ? UIImage(systemName: "star.fill")
      : UIImage(systemName: "star"),
      for: .normal
    )
  }
  
  private func addViews() {
    // Create necessary views
    let headerContainer = UIView()
    let footerContainer = UIView()
    
    // Add views
    headerContainer.addSubview(titleLabel)
    headerContainer.addSubview(ratingImageView)
    headerContainer.addSubview(ratingLabel)
    footerContainer.addSubview(pillView)
    footerContainer.addSubview(actionButton)
    
    cardView.addSubview(poster)
    cardView.addSubview(headerContainer)
    cardView.addSubview(descriptionLabel)
    cardView.addSubview(footerContainer)
    addSubview(cardView)
    
    // Property setup
    cardView.setShadowBorder()
    footerContainer.backgroundColor = .footerColor
    
    // Constraining
    cardView.insetsToSuperview(edges: UIConstants.InformativeContentCollectionViewCell.cardInsets)
    
    poster.insetsTo(
      topAnchor: cardView.topAnchor,
      bottomAnchor: cardView.bottomAnchor,
      leadingAnchor: cardView.leadingAnchor
    )
    
    poster.setWidthConstraint(self.bounds.width / UIConstants.InformativeContentCollectionViewCell.posterRatio)
    
    headerContainer.insetsTo(
      topAnchor: cardView.topAnchor,
      leadingAnchor: poster.trailingAnchor,
      trailingAnchor: cardView.trailingAnchor)
    
    titleLabel.insetsTo(
      topAnchor: headerContainer.topAnchor,
      bottomAnchor: headerContainer.bottomAnchor,
      leadingAnchor: headerContainer.leadingAnchor,
      constant: UIConstants.InformativeContentCollectionViewCell.titleInsetConstant
    )
    
    ratingImageView.insetsTo(
      topAnchor: headerContainer.topAnchor,
      leadingAnchor: titleLabel.trailingAnchor,
      constant: UIConstants.InformativeContentCollectionViewCell.ratingImageInsetConstant
    )
    ratingImageView.setSizeConstraint(UIConstants.InformativeContentCollectionViewCell.ratingImageSize)
    
    ratingLabel.insetsTo(
      topAnchor: headerContainer.topAnchor,
      leadingAnchor: ratingImageView.trailingAnchor,
      trailingAnchor: headerContainer.trailingAnchor,
      constant: UIConstants.InformativeContentCollectionViewCell.ratingLabelInsetConstant
    )
    
    descriptionLabel.insetsTo(
      topAnchor: headerContainer.bottomAnchor,
      leadingAnchor: poster.trailingAnchor,
      trailingAnchor: cardView.trailingAnchor,
      constant: UIConstants.InformativeContentCollectionViewCell.descriptionLabelInsetConstant
    )

    footerContainer.insetsGreaterThanOrEqualsTo(
      topAnchor: descriptionLabel.bottomAnchor,
      constant: UIConstants.InformativeContentCollectionViewCell.footerInsetConstant
    )
    
    footerContainer.insetsTo(
      bottomAnchor: cardView.bottomAnchor,
      leadingAnchor: poster.trailingAnchor,
      trailingAnchor: cardView.trailingAnchor
    )
    footerContainer.setHeightConstraint(UIConstants.InformativeContentCollectionViewCell.footerHeight)

    pillView.insetsTo(
      topAnchor: footerContainer.topAnchor,
      bottomAnchor: footerContainer.bottomAnchor,
      leadingAnchor: footerContainer.leadingAnchor,
      edges: UIConstants.InformativeContentCollectionViewCell.pillViewInsets
    )
    
    actionButton.insetsTo(
      leadingAnchor: pillView.trailingAnchor,
      trailingAnchor: footerContainer.trailingAnchor,
      centerYAnchor: pillView.centerYAnchor,
      constant: UIConstants.InformativeContentCollectionViewCell.actionButtonInsetconstant
    )
    actionButton.setSizeConstraint(UIConstants.InformativeContentCollectionViewCell.actionButtonSize)
  }
}
