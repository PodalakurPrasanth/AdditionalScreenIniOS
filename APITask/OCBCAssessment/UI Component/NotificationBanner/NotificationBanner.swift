//
//  NotificationBanner.swift
//  TopNotificationRecipe
//
//  Created by Dushyant Bansal on 11/02/18.
//  Copyright © 2018 db42.in. All rights reserved.
//
import Foundation
import UIKit

class NotificationBanner {
    
    let labelLeftMarging = CGFloat(16)
    let labelTopMargin = CGFloat(24)
    let animateDuration = 0.5
    let bannerAppearanceDuration: TimeInterval = 2
    
    var notificationShown: Bool = false
    var superview: UIViewController?
    
    init(superview: UIViewController) {
        self.superview = superview
    }
    
    func show(_ text: String, success: Bool = false) {
        guard !notificationShown else { return }
        guard superview != nil else { return }
        guard var superView = superview!.view else { return }
        if let navSuperView = superview!.navigationController?.view {
            superView = navSuperView
        }
        
        let height = CGFloat(64)
        let superViewWidth = superView.bounds.size.width
        let width = superViewWidth * 0.95
        let padding = (superViewWidth - width) / 2
        var topSafeArea : CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            topSafeArea = window?.safeAreaInsets.top ?? 0
        }
        
        let bannerView = UIView(frame: CGRect(x: padding, y: 0-height, width: width, height: height))
        bannerView.layer.opacity = 1
        bannerView.backgroundColor = success ? Color.notificationGreen : Color.notificationRed
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.layer.cornerRadius = 10
        
        let label = UILabel(frame: CGRect.zero)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.text = text.isEmpty ? (success ? "Success" : "Error") : text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        notificationShown = true
        
        bannerView.addSubview(label)
        superView.addSubview(bannerView)
        
        let labelCenterYContstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: bannerView, attribute: .centerY, multiplier: 1, constant: 0)
        let labelCenterXConstraint = NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: bannerView, attribute: .centerX, multiplier: 1, constant: 0)
        let labelWidthConstraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width - labelLeftMarging*2)
        let labelTopConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: bannerView, attribute: .top, multiplier: 1, constant: labelTopMargin)
        
        let bannerWidthConstraint = NSLayoutConstraint(item: bannerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        let bannerCenterXConstraint = NSLayoutConstraint(item: bannerView, attribute: .centerX, relatedBy: .equal, toItem: superView, attribute: .centerX, multiplier: 1, constant: 0)
        let bannerTopConstraint = NSLayoutConstraint(item: bannerView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: 0-height)
        
        NSLayoutConstraint.activate([labelCenterYContstraint, labelCenterXConstraint, labelWidthConstraint, labelTopConstraint, bannerWidthConstraint, bannerCenterXConstraint, bannerTopConstraint])
        
        UIView.animate(withDuration: animateDuration) {
            bannerTopConstraint.constant = 0 + padding + topSafeArea
            superView.layoutIfNeeded()
        }
        
        //remove subview after time 2 sec
        UIView.animate(withDuration: animateDuration, delay: bannerAppearanceDuration, options: [], animations: {
            bannerTopConstraint.constant = 0 - bannerView.frame.height - padding - topSafeArea
            superView.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                self.notificationShown = false
                bannerView.removeFromSuperview()
            }
        })
    }
}
