//
//  TransferPresenter.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

protocol TransferPresenterDelegate{
    func getPayeeSuccess(model: PayeeResponseModel)
    func getTransferSuccess(model: TransferResponseModel)
    func fail(error: ErrorType)
}

class TransferPresenter {
    
    var delegate: TransferPresenterDelegate
    
    init(delegate: TransferPresenterDelegate){
        self.delegate = delegate
    }
    
    func getPayees(){
        IMLoadingManager.showLoading()
        APIManager.payee { result in
            IMLoadingManager.hideLoading()
            switch result{
            case .success(let model):
                self.delegate.getPayeeSuccess(model: model)
            case .failure(let error):
                self.delegate.fail(error: error)
            }
        }
    }
    
    func transfer(model: TransferRequestModel){
        IMLoadingManager.showLoading()
        APIManager.transfer(model: model) { result in
            IMLoadingManager.hideLoading()
            switch result{
            case .success(let model):
                self.delegate.getTransferSuccess(model: model)
            case .failure(let error):
                self.delegate.fail(error: error)
            }
        }
    }
}
