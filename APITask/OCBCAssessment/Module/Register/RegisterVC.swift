//
//  RegisterVC.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import UIKit

class RegisterVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var usernameCustomTextField: CustomTextField!
    @IBOutlet weak var passwordCustomTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordCustomTextField: CustomTextField!
    @IBOutlet weak var registerCustomButton: CustomButton!
    
    // MARK: - Properties
    var presenter: RegisterPresenter?
}

//MARK: - UIViewController
extension RegisterVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBackButton()
        self.setupUI()
        self.setupPresenter()
    }
    
}

//MARK: - Functions
extension RegisterVC {
    private func setupUI(){
        self.setupHideKeyboardWhenTappedAround()
        self.setupCustomTextField()
        self.setupCustomButton()
        
    }
    
    private func setupCustomTextField(){
        self.usernameCustomTextField.textField.delegate = self
        self.passwordCustomTextField.textField.delegate = self
        self.confirmPasswordCustomTextField.textField.delegate = self
    }
    
    private func setupCustomButton(){
        self.registerCustomButton.button.addTarget(self, action: #selector(registerAction(sender:)), for: .touchUpInside)
    }
    
    private func setupPresenter(){
        self.presenter = RegisterPresenter(delegate: self)
    }
    
    @objc func registerAction(sender: UIButton) {
        self.usernameCustomTextField.showErrorMessage = self.usernameCustomTextField.textIsEmpty()
        self.passwordCustomTextField.showErrorMessage = self.passwordCustomTextField.textIsEmpty()
        self.checkConfirmPassword()
        guard !self.usernameCustomTextField.textIsEmpty(),
              !self.passwordCustomTextField.textIsEmpty(),
              !self.confirmPasswordCustomTextField.textIsEmpty(),
              confirmPasswordIsMatch()
        else{
            return
        }
        self.presenter?.register(model: RegisterRequestModel(username: self.usernameCustomTextField.textField.text!, password: self.passwordCustomTextField.textField.text!))
    }
    
    private func confirmPasswordIsMatch() -> Bool{
        return self.passwordCustomTextField.textField.text == self.confirmPasswordCustomTextField.textField.text
    }
    
    private func checkConfirmPassword(){
        if self.confirmPasswordCustomTextField.textIsEmpty() {
            self.confirmPasswordCustomTextField.errorMessage = "Confirm password is required"
            self.confirmPasswordCustomTextField.showErrorMessage = true
        }else{
            if !self.passwordCustomTextField.textIsEmpty() && !confirmPasswordIsMatch() {
                self.confirmPasswordCustomTextField.errorMessage = "Confirm password not match"
                self.confirmPasswordCustomTextField.showErrorMessage = true
            }else{
                self.confirmPasswordCustomTextField.showErrorMessage = false
            }
        }
    }
    
    private func goToHome(){
        DispatchQueue.main.async {
            let vc = UINavigationController(rootViewController: HomeVC())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true){
                self.navigationController?.popViewController(animated: false)
            }
        }
    }
}

//MARK: - UITextFieldDelegate
extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.usernameCustomTextField.textField:
            self.usernameCustomTextField.showErrorMessage = self.usernameCustomTextField.textIsEmpty()
        case self.passwordCustomTextField.textField:
            self.passwordCustomTextField.showErrorMessage = self.passwordCustomTextField.textIsEmpty()
            
            if !self.confirmPasswordCustomTextField.textIsEmpty(){
                if !self.passwordCustomTextField.textIsEmpty() && !confirmPasswordIsMatch() {
                    self.confirmPasswordCustomTextField.errorMessage = "Confirm password not match"
                    self.confirmPasswordCustomTextField.showErrorMessage = true
                }else{
                    self.confirmPasswordCustomTextField.showErrorMessage = false
                }
            }
        case self.confirmPasswordCustomTextField.textField:
            self.checkConfirmPassword()
        default:
            break
        }
    }
}

//MARK: - RegisterPresenterDelegate
extension RegisterVC: RegisterPresenterDelegate {
    func registerSuccess(model: RegisterResponseModel) {
        guard let token = model.token,
              let username = self.usernameCustomTextField.textField.text
        else { return self.showErrorMessage(message: "Error") }
        UserData.shared.saveToken(token)
        UserData.shared.saveUsername(username)
        self.goToHome()
    }
    
    func registerFail(error: ErrorType) {
        self.showErrorMessage(message: error.errorDescription)
    }
    
}
