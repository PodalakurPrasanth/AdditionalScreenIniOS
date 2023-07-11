//
//  CustomTextField.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 12/01/2022.
//

import UIKit

@IBDesignable
class CustomTextField: UIView {
    
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet private weak var arrorDownImage: UIImageView!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    @IBOutlet weak var textFieldRightConstraint: NSLayoutConstraint!
    
    @IBInspectable var title: String? = "Title" {
        didSet {
            self.setupTitleLabel()
        }
    }
    
    @IBInspectable var placeHolder: String?{
        didSet {
            self.setupTextFieldPlaceHolder()
        }
    }
    
    @IBInspectable var isSecureTextEntry: Bool = false {
        didSet {
            self.setupTextFieldisSecureTextEntry()
        }
    }
    
    @IBInspectable var dropDownImage: Bool = false{
        didSet {
            self.setupDropDown()
        }
    }
    
    @IBInspectable var errorMessage: String = "" {
        didSet {
            self.setupErrorMessageLabel()
        }
    }
    
    @IBInspectable var showErrorMessage: Bool = true{
        didSet {
            self.showErrorMessageLabel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupUI()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupUI()
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        setupUI()
        contentView?.prepareForInterfaceBuilder()
    }
    
    private func setup() {
        contentView = loadNib()
        contentView.frame = bounds
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": contentView!]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": contentView!]))
    }
    
    private func setupUI(){
        if #available(iOS 13.0, *) {
            #if TARGET_INTERFACE_BUILDER
            self.container.layer.borderColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
            #else
            self.container.layer.borderColor = Color.defaultBlack.cgColor
            #endif
        } else {
            self.container.layer.borderColor = UIColor.black.cgColor
        }
        self.container.layer.borderWidth = 2
        self.setupTitleLabel()
        self.setupTextFieldPlaceHolder()
        self.setupTextFieldisSecureTextEntry()
        self.setupDropDown()
        self.setupErrorMessageLabel()
        self.showErrorMessageLabel()
    }
    
    private func setupTitleLabel(){
        self.titleLabel.text = self.title
    }
    
    private func setupTextFieldPlaceHolder(){
        self.textField.placeholder = self.placeHolder
    }
    
    private func setupTextFieldisSecureTextEntry(){
        self.textField.isSecureTextEntry = self.isSecureTextEntry
    }
    
    private func setupDropDown(){
        if self.dropDownImage {
            self.arrorDownImage.isUserInteractionEnabled = true
            self.arrorDownImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(arrowDownImageAction(sender:))))
        }
        self.textFieldRightConstraint.constant = dropDownImage ? 40 : 15
        self.arrorDownImage.isHidden = !dropDownImage
    }
    
    private func setupErrorMessageLabel(){
        self.errorMessageLabel.text = self.errorMessage
    }
    
    private func showErrorMessageLabel(){
        if self.showErrorMessage {
            self.errorMessageLabel.text = self.errorMessage
        }else{
            //not break height constraint on ibdesignable
            self.errorMessageLabel.text = " "
        }
    }
    
    func textIsEmpty() -> Bool{
        return self.textField.text?.isEmpty ?? true
    }
    
    @objc private func arrowDownImageAction(sender: UIButton){
        self.textField.becomeFirstResponder()
    }

}

extension CustomTextField {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                self.setupUI()
            }
        }
    }
}
