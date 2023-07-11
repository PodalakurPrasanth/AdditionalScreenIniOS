//
//  API.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

fileprivate class BaseURL {
    static let base = "https://green-thumb-64168.uc.r.appspot.com"
    
    enum Path: String {
        case login = "/login"
        case register = "/register"
        case balance = "/balance"
        case transactions = "/transactions"
        case payees = "/payees"
        case transfer = "/transfer"
    }
}

class API {
    static let loginURL = BaseURL.base + BaseURL.Path.login.rawValue
    static let registerURL = BaseURL.base + BaseURL.Path.register.rawValue
    static let balanceURL = BaseURL.base + BaseURL.Path.balance.rawValue
    static let transactionsURL = BaseURL.base + BaseURL.Path.transactions.rawValue
    static let payeesURL = BaseURL.base + BaseURL.Path.payees.rawValue
    static let transferURL = BaseURL.base + BaseURL.Path.transfer.rawValue
}
