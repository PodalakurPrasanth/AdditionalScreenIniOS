//
//  String+Extensions.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

extension String {
    func toDate(withFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        dateFormatter.locale = Locale(identifier: "en_GB")
        return dateFormatter.date(from: self)
    }
}
