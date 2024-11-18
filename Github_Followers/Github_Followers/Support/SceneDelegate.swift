//
//  SceneDelegate.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 27/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // This method is called when the scene is about to be connected. It’s the ideal place to set up your main UI, such as the root view controller and the window.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = GFTabBarController()   // created a tab bar controller with two controller
        window?.makeKeyAndVisible()                         // makes the window appear on screen

        configureNavigationBar()
    }

    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemGreen
    }

    //MARK: Life Cycle Methods.
    func sceneDidDisconnect(_ scene: UIScene) {
        print("This method is called when the scene is being released by the system, such as when the app is sent to the background or the session is discarded. You can release resources that are tied to the scene here.")
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("This method is called when the scene transitions from an inactive to an active state. You can restart tasks that were paused or not yet started.")
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("Called when the scene is about to go from active to inactive. This is usually due to an interruption like an incoming call. You might pause ongoing tasks here.")
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Called when the scene is transitioning from the background to the foreground. You can undo any changes made when entering the background here.")
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("This method is called when the scene is transitioning to the background. You can save data or release shared resources here to prepare for a possible reactivation of the scene.")
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

