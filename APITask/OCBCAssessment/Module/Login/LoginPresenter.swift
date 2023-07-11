//
//  LoginPresenter.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation

protocol LoginPresenterDelegate{
    func loginSuccess(model: LoginResponseModel)
    func loginFail(error: ErrorType)
}

class LoginPresenter {
    
    var urlSession: URLSession
    var urlString: String
    var delegate: LoginPresenterDelegate
    
    init(urlSession: URLSession = .shared, urlString: String, delegate: LoginPresenterDelegate){
        self.urlSession = urlSession
        self.urlString = urlString
        self.delegate = delegate
    }
    
    func login(model: LoginRequestModel){
        IMLoadingManager.showLoading()
        APIManager.login(model: model) { result in
            IMLoadingManager.hideLoading()
            switch result{
            case .success(let model):
                self.delegate.loginSuccess(model: model)
            case .failure(let error):
                self.delegate.loginFail(error: error)
            }
        }
    }
}
