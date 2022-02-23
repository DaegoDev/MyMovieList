//
//  SegmentButtonTableViewCell.swift
//  MyMovieList
//

import UIKit

final class SegmentButtonCollectionViewCell: UICollectionViewCell {
  
  private lazy var button = UIButton()
  private var action: (() -> Void)?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  func setup(with dataSource: SegmenControlButtonDataSource) {
    button.setTitle(dataSource.title, for: .normal)
    button.backgroundColor = dataSource.isSelected ? .systemBlue : .white
    button.setTitleColor(dataSource.isSelected ? .white : .black, for: .normal)
    action = dataSource.action
    button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
  }
  
  private func addViews() {
    contentView.addSubview(button)
    button.insetsToSuperview()
  }
  
  @objc func onButtonTapped() {
    action?()
  }
}
