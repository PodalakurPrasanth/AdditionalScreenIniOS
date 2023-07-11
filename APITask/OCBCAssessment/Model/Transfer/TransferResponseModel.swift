//
//  TransferResponseModel.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

struct TransferResponseModel: Codable {
    let status: Status
    //success
    let transactionId: String?
    let amount: Int?
    let description: String?
    let recipientAccount: String?
    //error
    let error: String?
}

/*
 {
     "status": "success",
     "transactionId": "61e107aded80d4f7646b8bad",
     "amount": 1000,
     "description": "testing",
     "recipientAccount": "9226-178-8806"
 }
 */
