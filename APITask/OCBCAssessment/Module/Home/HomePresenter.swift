//
//  HomePresenter.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 14/01/2022.
//

import Foundation

protocol HomePresenterDelegate{
    func getBalanceSuccess(model: BalanceResponseModel)
    func getTransactions(model: TransactionResponseModel)
    func fail(error: ErrorType)
}

class HomePresenter {
    
    var delegate: HomePresenterDelegate
    
    private let dispatchGroup = DispatchGroup()
    
    init(delegate: HomePresenterDelegate){
        self.delegate = delegate
    }
    
    func getHomeData(){
        IMLoadingManager.showLoading()
        getBalance()
        getTransactions()
        dispatchGroup.notify(queue: .main) {
            // whatever you want to do when both are done
            IMLoadingManager.hideLoading()
        }
    }
    
    func getBalance(){
        dispatchGroup.enter()
        APIManager.balance { result in
            self.dispatchGroup.leave()
            switch result{
            case .success(let model):
                self.delegate.getBalanceSuccess(model: model)
            case .failure(let error):
                self.delegate.fail(error: error)
            }
        }
    }
    
    func getTransactions(){
        dispatchGroup.enter()
        APIManager.transaction { result in
            self.dispatchGroup.leave()
            switch result{
            case .success(let model):
                self.delegate.getTransactions(model: model)
            case .failure(let error):
                self.delegate.fail(error: error)
            }
        }
    }
}
