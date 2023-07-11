//
//  Preference.swift
//  Pedev20
//
//  Created by Hedy Pamungkas on 06/12/18.
//  Copyright © 2018 Indoalliz. All rights reserved.
//

import Foundation

struct Preference {
    static func set(value: Any?, forKey key: PreferenceKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func getString(forKey key: PreferenceKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func getDate(forKey key: PreferenceKey) -> Date? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? Date
    }
    
    static func getArray(forKey key: PreferenceKey) -> [Any]? {
        return UserDefaults.standard.array(forKey: key.rawValue)
    }
    
    static func getInt(forKey key: PreferenceKey) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    static func getBool(forKey key: PreferenceKey) -> Bool? {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    static func setStruct<T: Codable>(_ value: T?, forKey key: PreferenceKey) {
        let data = try? JSONEncoder().encode(value)
        set(value: data, forKey: key)
    }
    
    static func setStructArray<T: Codable>(_ value: [T], forKey key: PreferenceKey) {
        let data = value.map { try? JSONEncoder().encode($0) }
        set(value: data, forKey: key)
    }
    
    static func structData<T>(_ type: T.Type, forKey key: PreferenceKey) -> T? where T : Decodable {
        guard let encodedData = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }
        
        return try! JSONDecoder().decode(type, from: encodedData)
    }
    
    static func structArrayData<T>(_ type: T.Type, forKey key: PreferenceKey) -> [T] where T : Decodable {
        guard let encodedData = UserDefaults.standard.array(forKey: key.rawValue) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
    
    static func clear(forKey key: PreferenceKey){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func clearAll(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
