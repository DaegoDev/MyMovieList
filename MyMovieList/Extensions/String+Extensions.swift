//
//  String+Extensions.swift
//  MyMovieList
//

import Foundation

extension String {
  
  func toCurrencyFormat() -> String {
    guard let value = Double(self) else { return "" }
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = .zero
    formatter.minimumFractionDigits = .zero
    return formatter.string(for: value) ?? ""
  }
  
  func toDateFormat() -> String {
    let fromDateFormatter = DateFormatter()
    fromDateFormatter.dateFormat = "YYYY-mm-d"

    let date = fromDateFormatter.date(from: self)
    
    let toDateformatter = DateFormatter()
    toDateformatter.dateFormat = "d MMM, YYY"

    return toDateformatter.string(from: date ?? Date())
  }
  
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
