//
//  Date+Extensions.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

extension Date {
    func toString(dateFormat: String = "d MMM yyyy") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_GB")
        return dateFormatter.string(from: self)
    }
}
