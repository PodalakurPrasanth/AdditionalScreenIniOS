//
//  UserData.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

class UserData {
    static let shared = UserData()
    private init() {}
}

//kAuthenticationToken
extension UserData {
    var token: String? {
        guard let value = Preference.getString(forKey: .kAuthenticationToken) else { return nil }
        return value
    }
    
    func saveToken(_ value: String){
        Preference.set(value: value, forKey: .kAuthenticationToken)
    }
    
    func removeToken(){
        Preference.set(value: nil, forKey: .kAuthenticationToken)
    }
}

//kUsername
extension UserData {
    var username: String? {
        guard let value = Preference.getString(forKey: .kUsername) else { return nil }
        return value
    }
    
    func saveUsername(_ value: String){
        Preference.set(value: value, forKey: .kUsername)
    }
    
    func removeUsername(){
        Preference.set(value: nil, forKey: .kUsername)
    }
}

//kBalance
extension UserData {
    var balance: Double? {
        guard let value = Preference.getString(forKey: .kBalance) else { return nil }
        return Double(value)
    }
    
    func saveBalance(_ value: Double){
        Preference.set(value: String(value), forKey: .kBalance)
    }
    
    func removeBalance(){
        Preference.set(value: nil, forKey: .kBalance)
    }
}

//kAccountNo
extension UserData {
    var accountNo: String? {
        guard let value = Preference.getString(forKey: .kAccountNo) else { return nil }
        return value
    }
    
    func saveAccountNo(_ value: String){
        Preference.set(value: value, forKey: .kAccountNo)
    }
    
    func removeAccountNo(){
        Preference.set(value: nil, forKey: .kAccountNo)
    }
}
