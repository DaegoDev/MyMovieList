//
//  SegmentControlCollectionViewCell.swift
//  MyMovieList
//

import UIKit

struct SegmenControlButtonDataSource {
  var title: String
  var isSelected: Bool
  var action: (() -> Void)?
}

final class SegmentControlTableViewCell: UITableViewCell {
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = .zero
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .backgroundColor
    return collectionView
  }()
  
  var dataSource: [SegmenControlButtonDataSource] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    collectionView.collectionViewLayout.invalidateLayout()
  }
  
  private func addViews() {
    contentView.addSubview(collectionView)
    collectionView.insetsToSuperview()
    collectionView.register(with: SegmentButtonCollectionViewCell.self)
  }
}

extension SegmentControlTableViewCell: UICollectionViewDelegate { }

extension SegmentControlTableViewCell: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return dataSource.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      with: SegmentButtonCollectionViewCell.self,
      for: indexPath
    ) else {
      return UICollectionViewCell()
    }
    
    cell.setup(with: dataSource[indexPath.row])
    
    return cell
  }
}

extension SegmentControlTableViewCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(
      width: UIScreen.main.bounds.width / CGFloat(dataSource.count),
      height: UIConstants.SegmenteControlTableViewCell.height
    )
  }
}
