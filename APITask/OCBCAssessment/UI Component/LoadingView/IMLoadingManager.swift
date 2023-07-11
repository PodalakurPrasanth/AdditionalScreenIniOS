//
//  IMLoadingManager.swift
//  IMcash
//
//  Created by Clapping Ape on 02/12/19.
//  Copyright © 2019 Indosat. All rights reserved.
//

import Foundation
import UIKit

class IMLoadingManager: NSObject {
    
    static var containerLoading:UIView?
    static var imgLoading:UIImageView!
    static var lblInfoLoading:UILabel!

    // MARK: showLoading
    public static func showLoading(_ message : String? = nil) {
        DispatchQueue.main.async {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            if (containerLoading == nil) {
                let container = UIView(frame: UIScreen.main.bounds)
                container.backgroundColor = UIColor.white.withAlphaComponent(0.1)
                container.addShadow()
                
                let loading = UIImageView(image: Image.loadingImage)
                loading.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
                loading.center = container.center
                loading.contentMode = .center
                loading.backgroundColor = .white
                
                loading.clipsToBounds = true
                
                let radius =  30.0
                loading.layer.cornerRadius = CGFloat(radius)
                loading.layer.masksToBounds = true
                
                
                var frame = loading.frame
                frame.origin.y -= 90
                loading.frame = frame
                container.addSubview(loading)
                imgLoading = loading
                containerLoading = container
                
                lblInfoLoading = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
                lblInfoLoading.textColor = Color.loadingCyan
                lblInfoLoading.center = container.center
                lblInfoLoading.textAlignment = .center
                containerLoading?.addSubview(lblInfoLoading)
            }
            
            if (message != nil && (message?.count)! > 0) {
                lblInfoLoading.text = message
                lblInfoLoading.isHidden = false
            } else {
                lblInfoLoading.isHidden = true
            }
            
            let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
            fullRotation.fromValue = NSNumber(floatLiteral: 0)
            fullRotation.toValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
            fullRotation.duration = 1.5
            fullRotation.repeatCount = .infinity
            imgLoading.layer.add(fullRotation, forKey: "360")
            
            delegate.window?.endEditing(true)
            delegate.window?.addSubview(containerLoading!)
        }
    }

    // MARK: hideLoading
    public static func hideLoading() {
        DispatchQueue.main.async {
            containerLoading?.removeFromSuperview()
        }
    }

}

