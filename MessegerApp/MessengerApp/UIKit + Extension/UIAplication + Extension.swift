//
//  UIAplication + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 18.12.2020.
//

import UIKit

//MARK: - Get the topmost viewController

extension UIApplication {
	class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

		if let navigation = base as? UINavigationController {
			return getTopViewController(base: navigation.visibleViewController)

		} else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
			return getTopViewController(base: selected)

		} else if let presented = base?.presentedViewController {
			return getTopViewController(base: presented)
		}
		return base
	}
}
