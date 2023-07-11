//
//  ErrorType.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

enum ErrorType: Error, Equatable {
    case dataError
    case missingToken
    case responseModelParsingError
    case invalidURLStringError
    case failedRequest(description: String)
    
    var errorDescription: String {
        switch self {
        case .dataError:
            return "Data Error"
        case .missingToken:
            return "Missing authorization token"
        case .responseModelParsingError:
            return "Model Parsing Error"
        case .invalidURLStringError:
            return "Invalid URL"
        case .failedRequest(let description):
            return description
        }
    }
}
