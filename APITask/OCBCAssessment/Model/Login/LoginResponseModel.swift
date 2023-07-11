//
//  LoginResponseModel.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

struct LoginResponseModel: Codable {
    let status: Status
    //success
    let token: String?
    let username: String?
    let accountNo: String?
    //error
    let error: String?
}

/*
 {
     "status": "success",
     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MTZlNzNlMDYyYWY0ZGQ5YmMyYzYxMWQiLCJ1c2VybmFtZSI6InRlc3QiLCJhY2NvdW50Tm8iOiIyOTcwLTExMS0zNjQ4IiwiaWF0IjoxNjQyMDY0NjYxLCJleHAiOjE2NDIwNzU0NjF9.xTUWPODKwgBPp9ZWvbrRRxvm4kk9Et_ZYICKV9wNvd8",
     "username": "test",
     "accountNo": "2970-111-3648"
 }
 */
