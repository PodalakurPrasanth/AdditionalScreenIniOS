//
//  PayeeResponseModel.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

struct PayeeResponseModel: Codable {
    let status: Status
    //success
    let data: [PayeeDataResponseModel]?
    //error
    let error: String?
}

struct PayeeDataResponseModel: Codable {
    let id: String
    let name: String
    let accountNo: String
}
/*
 {
     "status": "success",
     "data": [
         {
             "id": "616d65d1d1b6fd6f12aeede6",
             "name": "Alvis",
             "accountNo": "9226-178-8806"
         },
         {
             "id": "616d65d1d1b6fd6f12aeede7",
             "name": "Elsie",
             "accountNo": "1265-467-6977"
         },
         {
             "id": "616d65d1d1b6fd6f12aeede8",
             "name": "Andy",
             "accountNo": "6554-630-9653"
         },
         {
             "id": "616d65d1d1b6fd6f12aeede9",
             "name": "Mohammed",
             "accountNo": "2833-703-6351"
         },
         {
             "id": "616d65d1d1b6fd6f12aeedea",
             "name": "Emmie",
             "accountNo": "7174-429-2937"
         }
     ]
 }
 */
