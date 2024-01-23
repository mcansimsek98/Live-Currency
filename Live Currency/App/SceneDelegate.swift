//
//  SceneDelegate.swift
//  Live Currency
//
//  Created by Mehmet Can Şimşek on 22.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let userDefaults = UserDefaults.standard
        let nav = UINavigationController()

        if userDefaults.bool(forKey: "isFirstEntry") {
            let mainRouter = MainRouter.start()
            if  let entry = mainRouter.entry {
                nav.viewControllers = [entry]
            }
        } else {
            let onBoardRouter = OnBoardRouter.start()
            if let entry = onBoardRouter.entry {
                nav.viewControllers = [entry]
            }
        }

        nav.navigationBar.isHidden = true
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
