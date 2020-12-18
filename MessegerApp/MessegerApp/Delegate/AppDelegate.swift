//
//  AppDelegate.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseStorage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		FirebaseApp.configure()
		GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
		return true
	}

	@available(iOS 9.0, *)
	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		return GIDSignIn.sharedInstance().handle(url)
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

//	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//
//	}
}

