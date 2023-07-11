//
//  RegisterPresenter.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

protocol RegisterPresenterDelegate{
    func registerSuccess(model: RegisterResponseModel)
    func registerFail(error: ErrorType)
}

class RegisterPresenter {
    
    var delegate: RegisterPresenterDelegate
    
    init(delegate: RegisterPresenterDelegate){
        self.delegate = delegate
    }
    
    func register(model: RegisterRequestModel){
        IMLoadingManager.showLoading()
        APIManager.register(model: model) { result in
            IMLoadingManager.hideLoading()
            switch result{
            case .success(let model):
                self.delegate.registerSuccess(model: model)
            case .failure(let error):
                self.delegate.registerFail(error: error)
            }
        }
    }
}
