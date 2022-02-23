//
//  FavoriteViewController.swift
//  MyMovieList
//

import UIKit

final class FavoriteViewController: UIViewController {
  // MARK: - UI Elements
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.width / 2)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .backgroundColor
    collectionView.register(with: InformativeContentCollectionViewCell.self)
    
    return collectionView
  }()
  
  // MARK: - Properties
  var viewModel: FavoriteViewModelProtocol?
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBindings()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel?.viewDidLoad()
  }
  
  // MARK: - Configuration
  private func setupBindings() {
    viewModel?.movies.bind({ [weak self] value in
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    })
    
    viewModel?.dataUpdated.bind({ [weak self] _ in
      DispatchQueue.main.async {
        self?.collectionView.reloadData()
      }
    })
  }
  
  private func addViews() {
    view.addSubview(collectionView)
    collectionView.insetsTo(
      topAnchor: view.safeAreaLayoutGuide.topAnchor,
      bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
      leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
      trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor
    )
  }
  
  private func setupUI() {
    addViews()
    
    title = Strings.favorites
    view.backgroundColor = .backgroundColor
  }
  
  // MARK: - Actions
  @objc private func dataUpdated() {
    viewModel?.viewDidLoad()
  }
}

// MARK: - UICollectionView Delegate/DataSoure
extension FavoriteViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    viewModel?.showMovieDetail(at: indexPath.row)
  }
}

extension FavoriteViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return viewModel?.movies.value?.count ?? .zero
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      with: InformativeContentCollectionViewCell.self,
      for: indexPath
    ) else {
      return UICollectionViewCell()
    }
    cell.dataSource = viewModel?.movies.value?[indexPath.row]
    cell.actionButtonPressed = {
      self.viewModel?.deleteFavorite(at: indexPath.row)
    }
    return cell
  }
}
