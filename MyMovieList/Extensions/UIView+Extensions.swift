//
//  UIView+Extensions.swift
//  MyMovieList
//

import Foundation
import UIKit

extension UIView {
  func insetsToSuperview(edges: UIEdgeInsets = .zero) {
    guard let superView = superview else { return }
    insetsTo(
      topAnchor: superView.topAnchor,
      bottomAnchor: superView.bottomAnchor,
      leadingAnchor: superView.leadingAnchor,
      trailingAnchor: superView.trailingAnchor,
      edges: edges
    )
  }
  
  func insetsToSuperview(constant: CGFloat) {
    insetsToSuperview(
      edges: UIEdgeInsets(top: constant, left: constant, bottom: constant, right: constant)
    )
  }
  
  func insetsTo(
    topAnchor: NSLayoutYAxisAnchor? = nil,
    bottomAnchor: NSLayoutYAxisAnchor? = nil,
    leadingAnchor: NSLayoutXAxisAnchor? = nil,
    trailingAnchor: NSLayoutXAxisAnchor? = nil,
    centerXAnchor: NSLayoutXAxisAnchor? = nil,
    centerYAnchor: NSLayoutYAxisAnchor? = nil,
    edges: UIEdgeInsets = .zero
  ) {
    translatesAutoresizingMaskIntoConstraints = false
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(
        equalTo: topAnchor, constant: edges.top
      ).isActive = true
    }
    
    if let bottomAnchor = bottomAnchor {
      self.bottomAnchor.constraint(
        equalTo: bottomAnchor, constant: -edges.bottom
      ).isActive = true
    }
    
    if let leadingAnchor = leadingAnchor {
      self.leadingAnchor.constraint(
        equalTo: leadingAnchor, constant: edges.left
      ).isActive = true
    }
    
    if let trailingAnchor = trailingAnchor {
      self.trailingAnchor.constraint(
        equalTo: trailingAnchor, constant: -edges.right
      ).isActive = true
    }
    
    if let centerXAnchor = centerXAnchor {
      self.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    if let centerYAnchor = centerYAnchor {
      self.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
  }
  
  func insetsTo(
    topAnchor: NSLayoutYAxisAnchor? = nil,
    bottomAnchor: NSLayoutYAxisAnchor? = nil,
    leadingAnchor: NSLayoutXAxisAnchor? = nil,
    trailingAnchor: NSLayoutXAxisAnchor? = nil,
    centerXAnchor: NSLayoutXAxisAnchor? = nil,
    centerYAnchor: NSLayoutYAxisAnchor? = nil,
    constant: CGFloat) {
      insetsTo(
        topAnchor: topAnchor,
        bottomAnchor: bottomAnchor,
        leadingAnchor: leadingAnchor,
        trailingAnchor: trailingAnchor,
        centerXAnchor: centerXAnchor,
        centerYAnchor: centerYAnchor,
        edges: UIEdgeInsets(
          top: constant,
          left: constant,
          bottom: constant,
          right: constant
        )
      )
    }
  
  func insetsGreaterThanOrEqualsTo(
    topAnchor: NSLayoutYAxisAnchor? = nil,
    bottomAnchor: NSLayoutYAxisAnchor? = nil,
    leadingAnchor: NSLayoutXAxisAnchor? = nil,
    trailingAnchor: NSLayoutXAxisAnchor? = nil,
    constant: CGFloat = .zero
  ) {
    insetsGreaterThanOrEqualsTo(
      topAnchor: topAnchor,
      bottomAnchor: bottomAnchor,
      leadingAnchor: leadingAnchor,
      trailingAnchor: trailingAnchor,
      edges: UIEdgeInsets(top: constant, left: constant, bottom: constant, right: constant)
    )
  }
  
  func insetsGreaterThanOrEqualsTo(
    topAnchor: NSLayoutYAxisAnchor? = nil,
    bottomAnchor: NSLayoutYAxisAnchor? = nil,
    leadingAnchor: NSLayoutXAxisAnchor? = nil,
    trailingAnchor: NSLayoutXAxisAnchor? = nil,
    edges: UIEdgeInsets = .zero
  ) {
    translatesAutoresizingMaskIntoConstraints = false
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(
        greaterThanOrEqualTo: topAnchor, constant: edges.top
      ).isActive = true
    }
    
    if let bottomAnchor = bottomAnchor {
      self.bottomAnchor.constraint(
        greaterThanOrEqualTo: bottomAnchor, constant: -edges.bottom
      ).isActive = true
    }
    
    if let leadingAnchor = leadingAnchor {
      self.leadingAnchor.constraint(
        greaterThanOrEqualTo: leadingAnchor, constant: edges.left
      ).isActive = true
    }
    
    if let trailingAnchor = trailingAnchor {
      self.trailingAnchor.constraint(
        greaterThanOrEqualTo: trailingAnchor, constant: -edges.right
      ).isActive = true
    }
  }
  
  func insetsLessThanOrEqualsTo(
    topAnchor: NSLayoutYAxisAnchor? = nil,
    bottomAnchor: NSLayoutYAxisAnchor? = nil,
    leadingAnchor: NSLayoutXAxisAnchor? = nil,
    trailingAnchor: NSLayoutXAxisAnchor? = nil,
    constant: CGFloat = .zero
  ) {
    insetsLessThanOrEqualsTo(
      topAnchor: topAnchor,
      bottomAnchor: bottomAnchor,
      leadingAnchor: leadingAnchor,
      trailingAnchor: trailingAnchor,
      edges: UIEdgeInsets(top: constant, left: constant, bottom: constant, right: constant)
    )
  }
  
  func insetsLessThanOrEqualsTo(
    topAnchor: NSLayoutYAxisAnchor? = nil,
    bottomAnchor: NSLayoutYAxisAnchor? = nil,
    leadingAnchor: NSLayoutXAxisAnchor? = nil,
    trailingAnchor: NSLayoutXAxisAnchor? = nil,
    edges: UIEdgeInsets = .zero
  ) {
    translatesAutoresizingMaskIntoConstraints = false
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(
        lessThanOrEqualTo: topAnchor, constant: edges.top
      ).isActive = true
    }
    
    if let bottomAnchor = bottomAnchor {
      self.bottomAnchor.constraint(
        lessThanOrEqualTo: bottomAnchor, constant: -edges.bottom
      ).isActive = true
    }
    
    if let leadingAnchor = leadingAnchor {
      self.leadingAnchor.constraint(
        lessThanOrEqualTo: leadingAnchor, constant: edges.left
      ).isActive = true
    }
    
    if let trailingAnchor = trailingAnchor {
      self.trailingAnchor.constraint(
        lessThanOrEqualTo: trailingAnchor, constant: -edges.right
      ).isActive = true
    }
  }

  
  func centerInParent() {
    centerHorizontallyInParent()
    centerVerticallyInParent()
  }
  
  func centerTo(
    centerXAnchor: NSLayoutXAxisAnchor? = nil,
    centerYAnchor: NSLayoutYAxisAnchor? = nil
  ) {
    if let centerXAnchor = centerXAnchor {
      self.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    if let centerYAnchor = centerYAnchor {
      self.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
  }
  
  func centerHorizontallyInParent() {
    guard let superView = superview else { return }
    
    centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
  }
  
  func centerVerticallyInParent() {
    guard let superView = superview else { return }
    
    centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
  }
  
  func setHeightConstraint(_ height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    
    removeHeightContratintsIfNeeded()
    
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func setHeightConstraintGreaterOrEqualtoToConstant(_ height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    
    removeHeightContratintsIfNeeded()
    
    heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
  }
  
  func setHeightConstraint(_ height: NSLayoutAnchor<NSLayoutDimension>) {
    translatesAutoresizingMaskIntoConstraints = false
    
    removeHeightContratintsIfNeeded()
    
    heightAnchor.constraint(equalTo: height).isActive = true
  }
  
  func removeHeightContratintsIfNeeded() {
    self.constraints.forEach {
      if
        $0.firstAttribute.rawValue == NSLayoutConstraint.Attribute.height.rawValue
      {
        self.removeConstraint($0)
      }
    }
  }
  
  func setWidthConstraint(_ width: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    
    removeWidthContratintsIfNeeded()
    
    self.widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func setWidthConstraint(_ width: NSLayoutAnchor<NSLayoutDimension>) {
    translatesAutoresizingMaskIntoConstraints = false
    
    removeWidthContratintsIfNeeded()
    
    self.widthAnchor.constraint(equalTo: width).isActive = true
  }
  
  func removeWidthContratintsIfNeeded() {
    self.constraints.forEach {
      if
        $0.firstAttribute.rawValue == NSLayoutConstraint.Attribute.width.rawValue
      {
        self.removeConstraint($0)
      }
    }
  }
  
  func setSizeConstraint(_ size: CGFloat) {
    setHeightConstraint(size)
    setWidthConstraint(size)
  }
  
  func roundCorners(
    corners: CACornerMask = [
      .layerMinXMinYCorner,
      .layerMinXMaxYCorner,
      .layerMaxXMinYCorner,
      .layerMaxXMaxYCorner
    ],
    radius: CGFloat = UIConstants.defaultCornerRadius,
    borderWidth: CGFloat = 0,
    borderColor: UIColor? = .clear
  ) {
    clipsToBounds = true
    layer.cornerRadius = radius
    layer.maskedCorners = corners
    layer.borderWidth = borderWidth
    layer.borderColor = borderColor?.cgColor ?? UIColor.clear.cgColor
  }
  
  func setGradientBackground(startColor: UIColor, endColor: UIColor) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.frame = bounds
    
    layer.insertSublayer(gradientLayer, at: 0)
  }
  
  func setRoundBorders(_ cornerRadius: CGFloat) {
    roundCorners(radius: cornerRadius)
  }
  
  func setShadowBorder() {
    guard let superview = superview else { return }
    let shadowView = UIView()
    superview.insertSubview(shadowView, at: .zero)

    shadowView.backgroundColor = .white
    shadowView.layer.cornerRadius = layer.cornerRadius
    shadowView.layer.shadowRadius = layer.cornerRadius / 2
    shadowView.layer.shadowOpacity = 0.4
    shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
    shadowView.layer.shadowColor = UIColor.black.cgColor
    
    shadowView.centerTo(centerXAnchor: self.centerXAnchor, centerYAnchor: self.centerYAnchor)
    shadowView.setWidthConstraint(self.widthAnchor)
    shadowView.setHeightConstraint(self.heightAnchor)

  }
}
