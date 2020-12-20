//
//  MainTabBarController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit

final class MainTabBarController: UITabBarController {

	//MARK: - Property

	private enum Metrics {
		static let peopleImageName: String = "person.2"
		static let conversationImageName: String = "bubble.left.and.bubble.right"
		static let oneTitleNavigationController: String = "People"
		static let twoTitleNavigationController: String = "Messages"
		static let defaultImageNavigationConroller: UIImage = #imageLiteral(resourceName: "queshion")

	}
	private let currentUser: MUser

	//MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBarController()
	}

	//MARK: - Init

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
		let peopleImage = UIImage(systemName: Metrics.peopleImageName,
								  withConfiguration: boldConfiguration)
		let conversationImage = UIImage(systemName: Metrics.conversationImageName,
										withConfiguration: boldConfiguration)

		tabBar.tintColor = .tabBarTintColor()

		viewControllers = [
		generateNavigationController(rootViewController: PeopleViewController(currentUser: currentUser),
									 title: Metrics.oneTitleNavigationController,
									 image: peopleImage ?? Metrics.defaultImageNavigationConroller),
		generateNavigationController(rootViewController: ListViewController(currentUser: currentUser),
									 title: Metrics.twoTitleNavigationController,
									 image: conversationImage ?? Metrics.defaultImageNavigationConroller)
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
