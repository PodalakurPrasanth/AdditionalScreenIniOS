//
//  UIViewController+Extensions.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 13/01/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupHideKeyboardWhenTappedAround() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissThisKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissThisKeyboard() {
        view.endEditing(true)
    }
    
    func setupNavigationBackButton(){
        self.navigationController?.navigationBar.backIndicatorImage = Image.backArrow
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = Image.backArrow
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = Color.defaultBlack
    }
    
    func showLoading(){
        DispatchQueue.main.async {
            IMLoadingManager.showLoading()
        }
    }
    
    func hideLoading(){
        DispatchQueue.main.async {
            IMLoadingManager.hideLoading()
        }
    }
    
    func showErrorMessage(message: String) {
        DispatchQueue.main.async {
            let notificationBanner =  NotificationBanner(superview: self)
            notificationBanner.show(message)
        }
    }
    
    func showSuccessMessage(message: String) {
        DispatchQueue.main.async {
            let notificationBanner =  NotificationBanner(superview: self)
            notificationBanner.show(message,success: true)
        }
    }
    
    func logout(){
        UserData.shared.removeToken()
        UserData.shared.removeBalance()
        UserData.shared.removeUsername()
        UserData.shared.removeAccountNo()
        if self.isModal {
            self.dismiss(animated: true, completion: nil)
        }else{
            UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: LoginVC())
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}

extension UIViewController {
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
