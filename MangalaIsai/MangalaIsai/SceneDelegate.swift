//
//  SceneDelegate.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 24/11/19.
//  Copyright © 2019 PARTHIBAN. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
        
            let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
            if #available(iOS 13.0, *) {
                let app = UIApplication.shared
                let statusBarHeight: CGFloat = app.statusBarFrame.size.height

                let statusbarView = UIView()
                statusbarView.backgroundColor = UIColor.appColorPink//(hexString: "953C17")
                window.addSubview(statusbarView)

                statusbarView.translatesAutoresizingMaskIntoConstraints = false
                statusbarView.heightAnchor
                    .constraint(equalToConstant: statusBarHeight).isActive = true
                statusbarView.widthAnchor
                    .constraint(equalTo:  window.widthAnchor, multiplier: 1.0).isActive = true
                statusbarView.topAnchor
                    .constraint(equalTo:  window.topAnchor).isActive = true
                statusbarView.centerXAnchor
                    .constraint(equalTo:  window.centerXAnchor).isActive = true

            } else {
                let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                statusBar?.backgroundColor = UIColor.appColorPink
            }
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        var viewController:UIViewController!
        if  Userdefault.shared.getUserID() > 0
        {
          viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        }
        else
        {
            viewController = storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as! CustomTabBarController
        }
        if #available(iOS 13.0, *){
            if let scene = UIApplication.shared.connectedScenes.first{
                guard let windowScene = (scene as? UIWindowScene) else { return }
                print(">>> windowScene: \(windowScene)")
                let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
                window.windowScene = windowScene //Make sure to do this
                window.rootViewController = viewController
                window.makeKeyAndVisible()
                appDelegate.window = window
            }
        } else {
            appDelegate.window?.rootViewController = viewController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let  openURLContext = URLContexts.first
        {
            ApplicationDelegate.shared.application(UIApplication.shared, open: openURLContext.url, sourceApplication: openURLContext.options.sourceApplication, annotation: openURLContext.options.annotation)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

