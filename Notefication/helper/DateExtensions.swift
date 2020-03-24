//
//  DateExtensions.swift
//  Notefication
//
//  Created by Maegan Wilson on 3/23/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import Foundation

extension Date {
  func toReadableString() -> String {
    var date: String
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MMM-dd"
    
    date = dateFormatter.string(from: self)
    
    return date
  }
}
