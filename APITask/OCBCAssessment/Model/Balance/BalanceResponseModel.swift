//
//  BalanceResponseModel.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

struct BalanceResponseModel: Codable {
    let status: Status
    //success
    let accountNo: String?
    let balance: Double?
    //error
    let error: String?
}

/*
 {
     "status": "success",
     "accountNo": "2970-111-3648",
     "balance": 46062.5
 }
 */
