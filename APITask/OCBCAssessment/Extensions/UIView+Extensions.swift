//
//  UIView+Extensions.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 12/01/2022.
//

import Foundation
import UIKit

extension UIView {
    
    /** Loads instance from nib with the same name. */
    @discardableResult
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    func addShadow() {
        layer.shadowOffset = CGSize(width:0, height:0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 1.00
        
        layer.shadowRadius = 4
        layer.shadowColor = Color.shadow.cgColor
        layer.shadowOpacity = 0.30
        layer.shadowOffset = CGSize(width:1, height:1)
        layer.masksToBounds = false
    }
    
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func setCornerRadiusWithoutShadow(cornerRadius: CGFloat = 5.0) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
    
    func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
}
