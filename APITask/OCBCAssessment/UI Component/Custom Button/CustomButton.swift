//
//  CustomButton.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation
import UIKit


@IBDesignable
class CustomButton: UIView {
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBInspectable var title: String? = "Button" {
        didSet {
            self.setupButtonTitle()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.setupButtonCornerRadius()
        }
    }
    
    @IBInspectable var whiteTheme: Bool = false {
        didSet {
            self.setupTheme()
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
        self.button.layer.cornerRadius = floor(min(self.button.bounds.height, self.button.bounds.width)/4)
        self.setupButtonTitle()
//        self.setupButtonTextColor()
        self.setupButtonCornerRadius()
        self.setupTheme()
    }
    
    private func setupButtonTitle(){
        self.button.setTitle(self.title, for: .normal)
    }
    
    private func setupButtonCornerRadius(){
        self.button.layer.cornerRadius = self.cornerRadius
    }
    
    private func setupTheme(){
        if whiteTheme {
            if #available(iOS 13.0, *) {
                #if TARGET_INTERFACE_BUILDER
                self.button.layer.borderColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
                self.button.setTitleColor((self.traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black), for: .normal)
                self.button.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white
                #else
                self.button.layer.borderColor = Color.defaultBlack.cgColor
                self.button.setTitleColor(Color.defaultBlack, for: .normal)
                self.button.backgroundColor = Color.defaultWhite
                #endif
            }else{
                self.button.layer.borderColor = UIColor.black.cgColor
                self.button.setTitleColor(.black, for: .normal)
                self.button.backgroundColor = .white
            }
            self.button.layer.borderWidth = 2
        }else{
            if #available(iOS 13.0, *) {
                #if TARGET_INTERFACE_BUILDER
                self.button.setTitleColor((self.traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.white), for: .normal)
                self.button.backgroundColor = (self.traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black)
                #else
                self.button.setTitleColor(Color.defaultWhite, for: .normal)
                self.button.backgroundColor = Color.defaultBlack
                #endif
            }else{
                self.button.setTitleColor(.black, for: .normal)
                self.button.backgroundColor = .black
            }
        }
    }
}

extension CustomButton {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                #if TARGET_INTERFACE_BUILDER
                self.button.layer.borderColor = self.traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
                #else
                self.button.layer.borderColor = Color.defaultBlack.cgColor
                #endif
            }
        }
    }
}
