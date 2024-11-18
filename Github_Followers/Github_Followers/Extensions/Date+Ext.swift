//
//  Date+Ext.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 18/10/24.
//

import Foundation

extension Date {

    // Convert the date into string format
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}

