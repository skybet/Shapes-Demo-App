//
//  SceneDelegate.swift
//  Shapes
//
//  Created by Matthew Glover on 09/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var shapesService = ShapesService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let shapesListViewController = ShapesListViewController()
        shapesListViewController.shapesService = shapesService
        
        let navigationController = UINavigationController(rootViewController: shapesListViewController)
        window = UIWindow(windowScene: windowScene)
        
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

