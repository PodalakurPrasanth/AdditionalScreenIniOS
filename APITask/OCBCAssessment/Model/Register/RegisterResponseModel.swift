//
//  RegisterResponseModel.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

struct RegisterResponseModel: Codable {
    let status: Status
    //success
    let token: String?
    //error
    let error: String?
}

/*
 {
     "status": "success",
     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MWUwNDkwZjMxNTA3MDU2MjczMzY5YTgiLCJ1c2VybmFtZSI6Im1hcnRpbiIsImFjY291bnRObyI6IjU4MjItMzIwLTYzODEiLCJpYXQiOjE2NDIwODg3MjAsImV4cCI6MTY0MjA5OTUyMH0.tmgXiYMUh_r1HAkP2tDsBg-reskzKLWu_QjgVKZ9U8w"
 }
 */
