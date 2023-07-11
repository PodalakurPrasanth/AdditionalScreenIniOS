//
//  LoginRequestModel.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

struct LoginRequestModel: Codable {
    let username: String
    let password: String
}

/*
 {
     "username": "test",
     "password": "asdasd"
 }
 */
