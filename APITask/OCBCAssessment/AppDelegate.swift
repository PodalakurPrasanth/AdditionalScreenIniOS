//
//  AppDelegate.swift
//  OCBCAssessment
//
//  Created by Ivan Martin on 12/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }
    
    //to avoid waking up in background when receiving silent notif. flow is started when application has activated
    func applicationDidBecomeActive(_ application: UIApplication) {
        window = UIWindow(frame:UIScreen.main.bounds)
        if UserData.shared.token != nil {
            let vc = UINavigationController(rootViewController: HomeVC())
            vc.modalPresentationStyle = .fullScreen
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }else{
            let vc = LoginVC()
            let navVC = UINavigationController(rootViewController: vc)
            window?.rootViewController = navVC
            window?.makeKeyAndVisible()
        }
    }

}
