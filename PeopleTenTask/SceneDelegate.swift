//
//  SceneDelegate.swift
//  PeopleTenTask
//
//  Created by Sandeepan Swain on 13/05/20.
//  Copyright © 2020 Sandeepan Swain. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene         = windowScene
        window?.rootViewController  = createTabbar()
        window?.makeKeyAndVisible()
        
    }
    
    func createSearchNC() -> UINavigationController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let lunchVC: UIViewController? = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self))
        lunchVC?.tabBarItem = UITabBarItem(title: "lunch", image: UIImage(named: "food")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "food"))
                
        return UINavigationController(rootViewController: lunchVC!)
      }
      
      
      func createFavoritesNC() -> UINavigationController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let internetsVC: UIViewController? = storyboard.instantiateViewController(withIdentifier: String(describing: InternetsViewController.self))
          
        internetsVC?.tabBarItem  = UITabBarItem(title: "Internets", image: UIImage(named: "hand")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), selectedImage: UIImage(named: "hand"))
        return UINavigationController(rootViewController: internetsVC!)
        
      }
    
      
      func createTabbar() -> UITabBarController {
          let tabbar                      = UITabBarController()
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = UIColor(red: 42.0/255.0, green: 42.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        
        let attrsNormal = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                  NSAttributedString.Key.font : UIFont(name: Strings.Font.rawValue, size: 10)!]
               UITabBarItem.appearance().setTitleTextAttributes(attrsNormal,
                                                                for: UIControl.State.normal)
        tabbar.viewControllers = [createSearchNC(), createFavoritesNC()]
          
          return tabbar
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
    }


}

