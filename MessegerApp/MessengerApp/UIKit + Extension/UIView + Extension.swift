//
//  UIView + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 16.12.2020.
//

import UIKit

extension UIView {
	func findViewController() -> UIViewController? {
		if let nextResponder = self.next as?
			UIViewController {
			return nextResponder
		}
		else if let nextResponder = self.next as? UIView {
			return nextResponder.findViewController()
		}
		else {
			return nil
		}
	}
}
