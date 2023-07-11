//
//  TransferRequestModel.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

struct TransferRequestModel: Codable{
    let receipientAccountNo: String
    let amount: Int
    let description: String
}
/*
 {
     "receipientAccountNo": "3762-351-2673",
     "amount": 1000,
     "description": "testing"
 }
 */
