//
//  MovieDetailAdditionalInfoCell.swift
//  MyMovieList
//

import UIKit

protocol TrailableCollectionViewCell: UICollectionViewCell {
  var dataSource: TrailableDataSource? { get set }
}

protocol TrailableDataSource {
  var cellType: TrailableCollectionViewCell.Type { get }
}

final class ContentWrappingCollectionView: UICollectionView {
  override var intrinsicContentSize: CGSize {
    contentSize
  }
  
  override var contentSize: CGSize {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }
}

final class TrailTableViewCell: UITableViewCell {
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = .zero
    
    let collectionView = ContentWrappingCollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .backgroundColor
    return collectionView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    dataSource = []
    collectionView.reloadData()
  }
  
  private var currentCellType: TrailableCollectionViewCell.Type?
  
  var dataSource: [TrailableDataSource] = [] {
    didSet {
      guard let cellType = dataSource.first?.cellType else {
        collectionView.reloadData()
        return
      }
      currentCellType = cellType.self
      registerCell()
      collectionView.reloadData()
    }
  }
  
  private func addViews() {
    contentView.addSubview(collectionView)
    collectionView.insetsToSuperview()
  }
  
  private func registerCell() {
    guard let currentCellType = currentCellType else { return }
    collectionView.register(with: currentCellType)
  }
}

extension TrailTableViewCell: UICollectionViewDelegate { }

extension TrailTableViewCell: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return  dataSource.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let currentCellType = currentCellType,
      let cell = collectionView.dequeueReusableCell(
      with: currentCellType,
      for: indexPath
    ) else {
      return UICollectionViewCell()
    }

    (cell as? TrailableCollectionViewCell)?.dataSource = dataSource[indexPath.row]
    
    return cell
  }
}
