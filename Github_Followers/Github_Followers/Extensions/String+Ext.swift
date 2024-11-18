//
//  String+Ext.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 18/10/24.
//

import Foundation

extension String {

    // convert the string into date to format the date
    func convertToDate() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "es_IN")
        dateFormatter.timeZone      = .current
        return dateFormatter.date(from: self)
    }

    // convert the string-date-string format
    func converToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
