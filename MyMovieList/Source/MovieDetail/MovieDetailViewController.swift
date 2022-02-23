//
//  MovieDetailViewController.swift
//  MyMovieList
//

import UIKit

final class MovieDetailViewController: UIViewController {
  // MARK: - Class Enums
  enum Sections: Int, CaseIterable {
    case poster
    case detail
    case control
    case additionalInfo
  }
  
  enum AdditionalInfoType {
    case overview
    case cast
  }
  
  // MARK: - UI Elements
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .backgroundColor
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    return tableView
  }()
  
  // MARK: - Properties
  var viewModel: MovieDetailViewModelProtocol?
  var currentAdditionalInfoType: AdditionalInfoType = .overview
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupBindings()
    registerCells()
    viewModel?.viewDidLoad()
  }
  
  // MARK: - Configuration
  private func setupBindings() {
    viewModel?.backdropPath.bind({ [weak self] _ in
      self?.tableView.reloadData()
    })
    
    viewModel?.isFetchingData.bind({ [weak self] _ in
      self?.title = self?.viewModel?.title
      self?.tableView.reloadData()
    })
  }
  
  private func setupUI() {
    view.backgroundColor = .backgroundColor
    addViews()
  }
  
  private func addViews() {
    view.addSubview(tableView)
    tableView.insetsTo(
      topAnchor: view.safeAreaLayoutGuide.topAnchor,
      bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
      leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
      trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor
    )
  }
  
  private func registerCells() {
    tableView.register(BackdropTableViewCell.self, forCellReuseIdentifier: BackdropTableViewCell.reuseIdentifier)
    tableView.register(DetailListTableViewCell.self, forCellReuseIdentifier: DetailListTableViewCell.reuseIdentifier)
    tableView.register(SegmentControlTableViewCell.self, forCellReuseIdentifier: SegmentControlTableViewCell.reuseIdentifier)
    tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.reuseIdentifier)
    tableView.register(TrailTableViewCell.self, forCellReuseIdentifier: TrailTableViewCell.reuseIdentifier)
  }
}

// MARK: - UITableView Delegate/Datasource
extension MovieDetailViewController: UITableViewDelegate { }

extension MovieDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Sections.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    let section = Sections(rawValue: indexPath.row)
    if section == .poster { cell = getPosterCell(tableView, indexPath: indexPath) }
    else if section == .detail { cell = getMovieDetailCell(tableView, indexPath: indexPath) }
    else if section == .control { cell = getSegmentControlCell(tableView, indexPath: indexPath) }
    else if section == .additionalInfo { cell = getAdditionalInfoCell(tableView, indexPath: indexPath) }
    cell.frame = CGRect(x: 0, y: 0, width: 150, height: 330)
    cell.setNeedsLayout()
    cell.layoutIfNeeded()
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  private func getPosterCell(_ tableview: UITableView, indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: BackdropTableViewCell.reuseIdentifier,
      for: indexPath
    ) as? BackdropTableViewCell else {
      return UITableViewCell()
    }
    cell.setBackdropImage(with: viewModel?.backdropPath.value)
    return cell
  }
  
  private func getMovieDetailCell(_ tableview: UITableView, indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: DetailListTableViewCell.reuseIdentifier,
      for: indexPath
    ) as? DetailListTableViewCell else {
      return UITableViewCell()
    }
    cell.dataSource = viewModel?.getMovieDetails() ?? []
    return cell
  }
  
  private func getSegmentControlCell(_ tableview: UITableView, indexPath: IndexPath) -> UITableViewCell  {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: SegmentControlTableViewCell.reuseIdentifier,
      for: indexPath
    ) as? SegmentControlTableViewCell else {
      return UITableViewCell()
    }
    var segmentControlDataSource = [SegmenControlButtonDataSource]()
    
    let overviewControl = SegmenControlButtonDataSource(
      title: Strings.overview,
      isSelected: currentAdditionalInfoType == .overview
    ) { [weak self] in
      self?.currentAdditionalInfoType = .overview
      tableview.reloadData()
    }
    
    let castControl = SegmenControlButtonDataSource(
      title: Strings.casting,
      isSelected: currentAdditionalInfoType == .cast
    ) { [weak self] in
      self?.currentAdditionalInfoType = .cast
      tableview.reloadData()
    }
    
    segmentControlDataSource.append(overviewControl)
    segmentControlDataSource.append(castControl)
    
    cell.dataSource = segmentControlDataSource
    return cell
  }
    
  private func getAdditionalInfoCell(_ tableview: UITableView, indexPath: IndexPath) -> UITableViewCell {
    switch currentAdditionalInfoType {
    case .overview:
      return getDescriptionCell(tableview, indexPath: indexPath)
    case .cast:
      return getCastCell(tableview, indexPath: indexPath)
    }
  }
  
  private func getDescriptionCell(_ tableview: UITableView, indexPath: IndexPath) -> UITableViewCell  {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: DescriptionTableViewCell.reuseIdentifier,
      for: indexPath
    ) as? DescriptionTableViewCell else {
      return UITableViewCell()
    }
    
    cell.setDescription(viewModel?.getMovieDescription() ?? "")
    
    return cell
  }
  
  private func getCastCell(_ tableview: UITableView, indexPath: IndexPath) -> UITableViewCell  {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: TrailTableViewCell.reuseIdentifier,
      for: indexPath
    ) as? TrailTableViewCell else {
      return UITableViewCell()
    }
    
    cell.dataSource = viewModel?.getCastDataSource() ?? []
    
    return cell
  }
}
