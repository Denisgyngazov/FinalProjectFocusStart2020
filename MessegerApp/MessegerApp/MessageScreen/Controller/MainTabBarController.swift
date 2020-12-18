//
//  MainTabBarController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit

final class MainTabBarController: UITabBarController {

	private let currentUser: MUser

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBarController()

	}

	init(currentUser: MUser) {
		self.currentUser = currentUser
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
		generateNavigationController(rootViewController: PeopleViewController(currentUser: currentUser),
										 title: "People",
										 image: peopleImage ?? #imageLiteral(resourceName: "queshion")),
		generateNavigationController(rootViewController: ListViewController(currentUser: currentUser),
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
