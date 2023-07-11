//
//  TransferVC.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import UIKit

class TransferVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var payeeCustomTextField: CustomTextField!
    @IBOutlet weak var amountCustomTextField: CustomTextField!
    @IBOutlet weak var descriptionCustomTextView: CustomTextView!
    @IBOutlet weak var transferNowCustomButton: CustomButton!
    
    //MARK: - Properties
    var presenter: TransferPresenter?
    
    var payeePicker: UIPickerView?
    var payees: [PayeeDataResponseModel] = []
    var selectedPayee : PayeeDataResponseModel? = nil
}

//MARK: - UIViewController
extension TransferVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBackButton()
        self.setupUI()
        self.setupPresenter()
    }
    
}

//MARK: - Functions
extension TransferVC {
    private func setupUI(){
        self.setupHideKeyboardWhenTappedAround()
        self.setupCustomTextField()
        self.setupCustomButton()
    }
    
    private func setupCustomTextField(){
        self.payeeCustomTextField.textField.delegate = self
        self.payeePicker = UIPickerView()
        payeePicker?.delegate = self
        payeePicker?.dataSource = self
        self.payeeCustomTextField.textField.inputView = self.payeePicker
        
        self.amountCustomTextField.textField.delegate = self
        self.amountCustomTextField.textField.keyboardType = .numberPad
        self.amountCustomTextField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.descriptionCustomTextView.textView.delegate = self
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == self.amountCustomTextField.textField {
            let holdstring = textField.text?.filter("0123456789".contains)
            textField.text = CurrencyFormatter.currency(number: Int(holdstring ?? "0") ?? 0)
        }
    }
    
    private func setupCustomButton(){
        self.transferNowCustomButton.button.addTarget(self, action: #selector(transferNowAction(sender:)), for: .touchUpInside)
    }
    
    private func setupPresenter(){
        self.presenter = TransferPresenter(delegate: self)
    }
    
    @objc func transferNowAction(sender: UIButton) {
        self.payeeCustomTextField.showErrorMessage = self.payeeCustomTextField.textIsEmpty()
        self.amountCustomTextField.showErrorMessage = self.amountCustomTextField.textIsEmpty()
        self.descriptionCustomTextView.showErrorMessage = self.descriptionCustomTextView.textIsEmpty()
        guard !self.payeeCustomTextField.textIsEmpty(),
              !self.amountCustomTextField.textIsEmpty(),
              !self.descriptionCustomTextView.textIsEmpty(),
              let payee = self.selectedPayee,
              let amountString = self.amountCustomTextField.textField.text,
              let description = self.descriptionCustomTextView.textView.text
        else{
            return
        }
        let amount = CurrencyFormatter.removeCurrency(string: amountString)
        
        self.presenter?.transfer(model: TransferRequestModel(receipientAccountNo: payee.accountNo, amount: amount, description: description))
    }
    
    private func reset(){
        DispatchQueue.main.async {
            self.payeeCustomTextField.textField.text = nil
            self.amountCustomTextField.textField.text = nil
            self.descriptionCustomTextView.textView.text = nil
            self.payees = []
            self.selectedPayee = nil
        }
    }
}

//MARK: - UITextFieldDelegate
extension TransferVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case self.payeeCustomTextField.textField:
            if self.payees.isEmpty {
                self.presenter?.getPayees()
                return false
            }else { return true }
        case self.amountCustomTextField.textField:
            if self.amountCustomTextField.textField.text == "" {
                self.amountCustomTextField.textField.text = CurrencyFormatter.currency(number: 0)
            }
            return true
        default:
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case self.payeeCustomTextField.textField:
            return false
        default:
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.payeeCustomTextField.textField:
            self.payeeCustomTextField.showErrorMessage = self.payeeCustomTextField.textIsEmpty()
        case self.amountCustomTextField.textField:
            self.amountCustomTextField.showErrorMessage = self.amountCustomTextField.textIsEmpty()
        default:
            break
        }
    }
}

//MARK: - UITextViewDelegate
extension TransferVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case self.descriptionCustomTextView.textView:
            self.descriptionCustomTextView.showErrorMessage = self.descriptionCustomTextView.textIsEmpty()
        default:
            break
        }
    }
}


//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension TransferVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.payees.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.payees[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.payeeCustomTextField.textField.text = self.payees[row].name
        self.selectedPayee = self.payees[row]
    }
    
}

//MARK: - TransferPresenterDelegate
extension TransferVC: TransferPresenterDelegate {
    func getPayeeSuccess(model: PayeeResponseModel) {
        guard let data = model.data else { return self.showErrorMessage(message: "Error") }
        DispatchQueue.main.async {
            self.payees = data
            self.payeeCustomTextField.textField.becomeFirstResponder()
            self.payeePicker?.selectRow(0, inComponent: 0, animated: false)
            self.payeeCustomTextField.textField.text = self.payees[0].name
            self.selectedPayee = self.payees[0]
            self.payeePicker?.reloadAllComponents()
        }
    }
    
    func getTransferSuccess(model: TransferResponseModel) {
        self.showSuccessMessage(message: "Success")
        self.reset()
    }
    
    func fail(error: ErrorType) {
        if error == .missingToken {
            URLSession.shared.invalidateAndCancel()
            self.logout()
        }else{
            self.showErrorMessage(message: error.errorDescription)
        }
    }
    
}
