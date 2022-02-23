//
//  PillView.swift
//  MyMovieList
//

import UIKit

final class PillView: UIView {
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.dataSource = self
    collectionView.register(with: PillViewCollectionViewCell.self)
    return collectionView
  }()
  
  private var pills: [String] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  func setPills(_ pills: [String]) {
    self.pills = pills
    collectionView.reloadData()
  }
  
  private func addViews() {
    addSubview(collectionView)
    collectionView.insetsToSuperview()
  }
}

extension PillView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pills.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      with: PillViewCollectionViewCell.self, for: indexPath
    ) else {
      return UICollectionViewCell()
    }
    cell.setPillText(pills[indexPath.row], with: .clear)
    return cell
  }
}
