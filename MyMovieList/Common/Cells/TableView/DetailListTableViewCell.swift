//
//  MovieDetailsTableViewCell.swift
//  MyMovieList
//

import UIKit

final class DetailListTableViewCell: UITableViewCell {

  private lazy var containerView = UIView()
  private lazy var contentStack: UIStackView = {
    let stack = UIStackView()
    stack.spacing = UIConstants.defaultItemSpacing
    stack.distribution = .fill
    stack.alignment = .fill
    stack.axis = .vertical
    
    return stack
  }()
  
  var dataSource: [[String: String]] = [] {
    didSet {
      setup()
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(code:) has not beeen implemented")
  }
  
  func setup() {
    contentStack.subviews.forEach { $0.removeFromSuperview() }
    var rowStack = UIStackView()
    contentStack.addArrangedSubview(rowStack)

    for item in dataSource {
      let titleLabel = UILabel()
      let valueLabel = UILabel()
      let container = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
      
      titleLabel.font = .bold(.size16)
      valueLabel.font = .regular(.size16)
      
      titleLabel.textAlignment = .center
      valueLabel.textAlignment = .center
      
      container.axis = .vertical
      container.spacing = UIConstants.smallSpacing
      
      titleLabel.text = item.first?.key
      valueLabel.text = item.first?.value
      
      if rowStack.subviews.count < UIConstants.DetailListTableViewCell.columnCount {
        rowStack.addArrangedSubview(container)
      } else {
        rowStack = UIStackView()
        rowStack.addArrangedSubview(container)
        contentStack.addArrangedSubview(rowStack)
      }
      
      rowStack.distribution = .fillEqually
      rowStack.alignment = .center
    }
  }
  
  private func addViews() {
    contentView.addSubview(containerView)
    containerView.addSubview(contentStack)
    
    containerView.insetsToSuperview(constant: UIConstants.defaultSpacing)
    contentStack.insetsToSuperview(constant: UIConstants.smallSpacing)
  }
}
