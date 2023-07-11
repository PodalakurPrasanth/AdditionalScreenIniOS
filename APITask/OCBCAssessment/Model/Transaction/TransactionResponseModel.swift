//
//  TransactionResponseModel.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

struct TransactionResponseModel: Codable {
    let status: Status
    //success
    let data: [TransactionDataResponseModel]?
    //error
    let error: String?
}

struct TransactionDataResponseModel: Codable {
    let transactionId: String
    let amount: Double
    let transactionDate: String
    let description: String?
    let transactionType: String
    let receipient: TransactionDataReceipientResponseModel
}
struct TransactionDataReceipientResponseModel: Codable {
    let accountNo: String
    let accountHolder: String
}

/*
 {
     "status": "success",
     "data": [
         {
             "transactionId": "61e107aded80d4f7646b8bad",
             "amount": 1000,
             "transactionDate": "2022-01-14T05:18:37.774Z",
             "description": "testing",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "9226-178-8806",
                 "accountHolder": "Alvis"
             }
         },
         {
             "transactionId": "61dc7c03bbff2cb74592416f",
             "amount": 2,
             "transactionDate": "2022-01-10T18:33:39.132Z",
             "description": "Test fox",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "7174-429-2937",
                 "accountHolder": "Emmie"
             }
         },
         {
             "transactionId": "61dc786720e4997cb2cf0987",
             "amount": 55,
             "transactionDate": "2022-01-10T18:18:15.055Z",
             "description": "test felix",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "7174-429-2937",
                 "accountHolder": "Emmie"
             }
         },
         {
             "transactionId": "61dc773220e4997cb2cf0980",
             "amount": 500,
             "transactionDate": "2022-01-10T18:13:06.547Z",
             "description": "Test Felix",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "7174-429-2937",
                 "accountHolder": "Emmie"
             }
         },
         {
             "transactionId": "61dc0966e9c8a43fff2bdbfc",
             "amount": 12,
             "transactionDate": "2022-01-10T10:24:38.197Z",
             "description": null,
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "2833-703-6351",
                 "accountHolder": "Mohammed"
             }
         },
         {
             "transactionId": "61dc090b25c0e8fab012b333",
             "amount": 123,
             "transactionDate": "2022-01-10T10:23:07.825Z",
             "description": "tr",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "6554-630-9653",
                 "accountHolder": "Andy"
             }
         },
         {
             "transactionId": "61dc08f325c0e8fab012b32e",
             "amount": 123,
             "transactionDate": "2022-01-10T10:22:43.211Z",
             "description": "tr",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "6554-630-9653",
                 "accountHolder": "Andy"
             }
         },
         {
             "transactionId": "61dc082825c0e8fab012b329",
             "amount": 1000,
             "transactionDate": "2022-01-10T10:19:20.138Z",
             "description": "test",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "6554-630-9653",
                 "accountHolder": "Andy"
             }
         },
         {
             "transactionId": "61dc07fee9c8a43fff2bdbf3",
             "amount": 1000,
             "transactionDate": "2022-01-10T10:18:38.674Z",
             "description": "test",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "6554-630-9653",
                 "accountHolder": "Andy"
             }
         },
         {
             "transactionId": "61d1a4900c78ce03d788a472",
             "amount": 10.5,
             "transactionDate": "2022-01-02T13:11:44.545Z",
             "description": "Test ios",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "2833-703-6351",
                 "accountHolder": "Mohammed"
             }
         },
         {
             "transactionId": "61d1a44583f425775922f2f7",
             "amount": 10.5,
             "transactionDate": "2022-01-02T13:10:29.892Z",
             "description": "Testing iOS 220102 20.10",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "1265-467-6977",
                 "accountHolder": "Elsie"
             }
         },
         {
             "transactionId": "61d1a3ce83f425775922f2ef",
             "amount": 20.5,
             "transactionDate": "2022-01-02T13:08:30.717Z",
             "description": "testing 020122 (4)",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "7174-429-2937",
                 "accountHolder": "Emmie"
             }
         },
         {
             "transactionId": "61d1a33f0c78ce03d788a46a",
             "amount": 20.75,
             "transactionDate": "2022-01-02T13:06:07.461Z",
             "description": "Testing iOS 3",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "6554-630-9653",
                 "accountHolder": "Andy"
             }
         },
         {
             "transactionId": "61d1a2280c78ce03d788a457",
             "amount": 20.25,
             "transactionDate": "2022-01-02T13:01:28.626Z",
             "description": "testing ios",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "6554-630-9653",
                 "accountHolder": "Andy"
             }
         },
         {
             "transactionId": "61d1a13c0c78ce03d788a451",
             "amount": 550.5,
             "transactionDate": "2022-01-02T12:57:32.131Z",
             "description": "Testing",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "6554-630-9653",
                 "accountHolder": "Andy"
             }
         },
         {
             "transactionId": "61d1a1280c78ce03d788a44c",
             "amount": 550.5,
             "transactionDate": "2022-01-02T12:57:12.988Z",
             "description": "Testing",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "6554-630-9653",
                 "accountHolder": "Andy"
             }
         },
         {
             "transactionId": "61d183f294c9bb6d3f79e436",
             "amount": 100,
             "transactionDate": "2022-01-02T10:52:34.177Z",
             "description": "testing 020122",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "7174-429-2937",
                 "accountHolder": "Emmie"
             }
         },
         {
             "transactionId": "61cc064a29f6900ba9142fbb",
             "amount": 1,
             "transactionDate": "2021-12-29T06:55:06.354Z",
             "description": "test",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "1265-467-6977",
                 "accountHolder": "Elsie"
             }
         },
         {
             "transactionId": "61cc054705b5989c7f715142",
             "amount": 1,
             "transactionDate": "2021-12-29T06:50:47.782Z",
             "description": "test",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "1265-467-6977",
                 "accountHolder": "Elsie"
             }
         },
         {
             "transactionId": "61cc053505b5989c7f71513d",
             "amount": 1,
             "transactionDate": "2021-12-29T06:50:29.030Z",
             "description": "test",
             "transactionType": "transfer",
             "receipient": {
                 "accountNo": "1265-467-6977",
                 "accountHolder": "Elsie"
             }
         }
     ]
 }
 */
