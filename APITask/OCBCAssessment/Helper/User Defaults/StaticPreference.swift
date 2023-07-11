//
//  StaticPreference.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

protocol StaticPreference {
    associatedtype output: Codable
    var key: PreferenceKey! { get set }
}

extension StaticPreference {
    func read() -> output? {
        return Preference.structData(output.self, forKey: key)
    }
    
    func save(model: output) {
        Preference.setStruct(model.self, forKey: key)
    }
    
    func clear() {
        Preference.clear(forKey: key)
    }
}

//class BalancePreference: StaticPreference {
//    typealias output = BalanceResponseModel
//    var key: PreferenceKey! = .balanceKey
//}
