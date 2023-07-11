

import Foundation

class APIManager {
    
    private static func request<T: Codable, U: Codable>(model: T, responseModel: U.Type, url: URL, method: Method, header: HeaderType = .basic, completionHandler: @escaping (Result<U, ErrorType>)->Void){
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if header == .authorization {
            guard let token = UserData.shared.token else {
                completionHandler(.failure(ErrorType.missingToken))
                return
            }
            request.setValue(token, forHTTPHeaderField: "Authorization")
        }
        
        if !(model is NilRequestBody) {
            request.httpBody = try? JSONEncoder().encode(model)
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                completionHandler(.failure(ErrorType.failedRequest(description: requestError.localizedDescription)))
                return
            }
            
            if let data = data{
                do {
                    let decoder = JSONDecoder()
                    //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model: U = try decoder.decode(U.self, from: data)
                    completionHandler(.success(model))
                } catch let error {
                    debugPrint("\n=====HTTPResponseError=====")
                    debugPrint("RESPONSE FROM \(error.localizedDescription)")
                    debugPrint("====================\n")
                    completionHandler(.failure(ErrorType.responseModelParsingError))
                }
            }else{
                completionHandler(.failure(ErrorType.dataError))
            }
        }
        
        dataTask.resume()
    }
    /*
    static func login(model: LoginRequestModel, urlString: String, urlSession: URLSession, completionHandler: @escaping (Result<LoginResponseModel, ErrorType>)->Void){
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = try? JSONEncoder().encode(model)
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            if let requestError = error {
                completionHandler(.failure(ErrorType.failedRequest(description: requestError.localizedDescription)))
                return
            }
            
            if let data = data, let model = try? JSONDecoder().decode(LoginResponseModel.self, from: data) {
                switch model.status {
                case .success:
                    completionHandler(.success(model))
                case .failed:
                    if model.error == ErrorType.missingToken.errorDescription {
                        completionHandler(.failure(ErrorType.missingToken))
                    }else{
                        completionHandler(.failure(ErrorType.failedRequest(description: model.error ?? "Error")))
                    }
                }
            }else{
                completionHandler(.failure(ErrorType.responseModelParsingError))
            }
        }
        
        dataTask.resume()
    }
    */
    static func login(model: LoginRequestModel, completionHandler: @escaping (Result<LoginResponseModel, ErrorType>)->Void){
        guard let url = URL(string: API.loginURL) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        self.request(model: model, responseModel: LoginResponseModel.self, url: url, method: .POST) { result in
            switch result {
            case .success(let model):
                switch model.status {
                case .success:
                    completionHandler(.success(model))
                case .failed:
                    completionHandler(.failure(ErrorType.failedRequest(description: model.error ?? "Error")))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func register(model: RegisterRequestModel, completionHandler: @escaping (Result<RegisterResponseModel, ErrorType>)->Void){
        guard let url = URL(string: API.registerURL) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        self.request(model: model, responseModel: RegisterResponseModel.self, url: url, method: .POST) { result in
            switch result {
            case .success(let model):
                switch model.status {
                case .success:
                    completionHandler(.success(model))
                case .failed:
                    completionHandler(.failure(ErrorType.failedRequest(description: model.error ?? "Error")))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func balance(completionHandler: @escaping (Result<BalanceResponseModel, ErrorType>)->Void){
        guard let url = URL(string: API.balanceURL) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        self.request(model: NilRequestBody(), responseModel: BalanceResponseModel.self, url: url, method: .GET, header: .authorization) { result in
            switch result {
            case .success(let model):
                switch model.status {
                case .success:
                    completionHandler(.success(model))
                case .failed:
                    if model.error == ErrorType.missingToken.errorDescription {
                        completionHandler(.failure(ErrorType.missingToken))
                    }else{
                        completionHandler(.failure(ErrorType.failedRequest(description: model.error ?? "Error")))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func transaction(completionHandler: @escaping (Result<TransactionResponseModel, ErrorType>)->Void){
        guard let url = URL(string: API.transactionsURL) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        self.request(model: NilRequestBody(), responseModel: TransactionResponseModel.self, url: url, method: .GET, header: .authorization) { result in
            switch result {
            case .success(let model):
                switch model.status {
                case .success:
                    completionHandler(.success(model))
                case .failed:
                    if model.error == ErrorType.missingToken.errorDescription {
                        completionHandler(.failure(ErrorType.missingToken))
                    }else{
                        completionHandler(.failure(ErrorType.failedRequest(description: model.error ?? "Error")))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func payee(completionHandler: @escaping (Result<PayeeResponseModel, ErrorType>)->Void){
        guard let url = URL(string: API.payeesURL) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        self.request(model: NilRequestBody(), responseModel: PayeeResponseModel.self, url: url, method: .GET, header: .authorization) { result in
            switch result {
            case .success(let model):
                switch model.status {
                case .success:
                    completionHandler(.success(model))
                case .failed:
                    if model.error == ErrorType.missingToken.errorDescription {
                        completionHandler(.failure(ErrorType.missingToken))
                    }else{
                        completionHandler(.failure(ErrorType.failedRequest(description: model.error ?? "Error")))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func transfer(model: TransferRequestModel, completionHandler: @escaping (Result<TransferResponseModel, ErrorType>)->Void){
        guard let url = URL(string: API.transferURL) else {
            completionHandler(.failure(ErrorType.invalidURLStringError))
            return
        }
        self.request(model: model, responseModel: TransferResponseModel.self, url: url, method: .POST, header: .authorization) { result in
            switch result {
            case .success(let model):
                switch model.status {
                case .success:
                    completionHandler(.success(model))
                case .failed:
                    if model.error == ErrorType.missingToken.errorDescription {
                        completionHandler(.failure(ErrorType.missingToken))
                    }else{
                        completionHandler(.failure(ErrorType.failedRequest(description: model.error ?? "Error")))
                    }
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
