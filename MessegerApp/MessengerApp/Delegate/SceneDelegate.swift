//
//  SceneDelegate.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene


		if let user = Auth.auth().currentUser {
			FirestoreService.shared.getUserData(user: user) { (result) in
				switch result {

				case .success(let muser):
					let mainTabBar = MainTabBarController(currentUser: muser)
					mainTabBar.modalPresentationStyle = .fullScreen
					self.window?.rootViewController = mainTabBar
				case .failure(_):
					self.window?.rootViewController = AuthenticationViewController()
				}
			}

		} else {
			window?.rootViewController = AuthenticationViewController()
		}

		window?.makeKeyAndVisible()
	}
}

