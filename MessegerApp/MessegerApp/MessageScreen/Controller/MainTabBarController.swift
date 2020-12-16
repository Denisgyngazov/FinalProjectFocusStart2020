//
//  MainTabBarController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit

final class MainTabBarController: UITabBarController {

	private let listViewController = ListViewController()
	private let peopleViewController = PeopleViewController()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBarController()



	}
}

//MARK: - Setup TabBarController

private extension MainTabBarController {
	func setupTabBarController() {
		let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
		let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)
		let conversationImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfiguration)
		tabBar.tintColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)

		viewControllers = [
		generateNavigationController(rootViewController: peopleViewController,
										 title: "People",
										 image: peopleImage ?? #imageLiteral(resourceName: "queshion")),
		generateNavigationController(rootViewController: listViewController,
									 title: "Conversation",
									 image: conversationImage ?? #imageLiteral(resourceName: "queshion"))

		]
	}
}

//MARK: - Setup NavigationController

private extension MainTabBarController {
	func generateNavigationController(rootViewController: UIViewController,
									  title: String,
									  image: UIImage) -> UIViewController {

		let navigationViewController = UINavigationController(rootViewController: rootViewController)
		navigationViewController.tabBarItem.title = title
		navigationViewController.tabBarItem.image = image

		return navigationViewController
	}
}
