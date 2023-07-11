//
//  LoginVC.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 12/01/2022.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var usernameCustomTextField: CustomTextField!
    @IBOutlet weak var passwordCustomTextField: CustomTextField!
    @IBOutlet weak var loginCustomButton: CustomButton!
    @IBOutlet weak var registerCustomButton: CustomButton!
    
    // MARK: - Properties
    var presenter: LoginPresenter?
}

//MARK: - UIViewController
extension LoginVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //from register
        if UserData.shared.token != nil {
            reset()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showErrorMessage(message: "error.errorDescription")
        self.setupUI()
        self.setupPresenter()
    }
}

//MARK: - Functions
extension LoginVC {
    
    private func setupUI(){
        self.setupHideKeyboardWhenTappedAround()
        self.setupCustomTextField()
        self.setupCustomButton()
    }
    
    private func setupCustomTextField(){
        self.usernameCustomTextField.textField.delegate = self
        self.passwordCustomTextField.textField.delegate = self
    }
    
    private func setupCustomButton(){
        self.loginCustomButton.button.addTarget(self, action: #selector(loginAction(sender:)), for: .touchUpInside)
        self.registerCustomButton.button.addTarget(self, action: #selector(registerAction(sender:)), for: .touchUpInside)
    }
    
    @objc private func loginAction(sender: UIButton) {
        self.usernameCustomTextField.showErrorMessage = self.usernameCustomTextField.textIsEmpty()
        self.passwordCustomTextField.showErrorMessage = self.passwordCustomTextField.textIsEmpty()
        guard !self.usernameCustomTextField.textIsEmpty(),
              !self.passwordCustomTextField.textIsEmpty()
        else { return }
        //Login action
//        self.showLoading()
        self.presenter?.login(model: LoginRequestModel(username: self.usernameCustomTextField.textField.text!, password: self.passwordCustomTextField.textField.text!))
    }
    
    @objc private func registerAction(sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.pushViewController(RegisterVC(), animated: true)
    }
    
    private func setupPresenter(){
        self.presenter = LoginPresenter(urlString: "https://green-thumb-64168.uc.r.appspot.com/login", delegate: self)
    }
    
    private func reset(){
        self.usernameCustomTextField.textField.text = nil
        self.usernameCustomTextField.showErrorMessage = false
        self.passwordCustomTextField.textField.text = nil
        self.passwordCustomTextField.showErrorMessage = false
    }
    
    private func goToHome(){
        DispatchQueue.main.async {
            let vc = UINavigationController(rootViewController: HomeVC())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true){
                self.reset()
            }
        }
    }

}

//MARK: - UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.usernameCustomTextField.textField:
            self.usernameCustomTextField.showErrorMessage = self.usernameCustomTextField.textIsEmpty()
        case self.passwordCustomTextField.textField:
            self.passwordCustomTextField.showErrorMessage = self.passwordCustomTextField.textIsEmpty()
        default:
            break
        }
    }
}

//MARK: - LoginPresenterDelegate
extension LoginVC: LoginPresenterDelegate {
    func loginSuccess(model: LoginResponseModel) {
        guard let token = model.token,
              let username = model.username
        else { return self.showErrorMessage(message: "Error") }
        UserData.shared.saveToken(token)
        UserData.shared.saveUsername(username)
        self.goToHome()
    }
    
    func loginFail(error: ErrorType) {
        self.showErrorMessage(message: error.errorDescription)
    }
    
}
