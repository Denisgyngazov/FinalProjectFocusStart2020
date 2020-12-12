//
//  UIButton + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import Foundation
import UIKit

extension UIButton {

	private enum Metrics {
		static let shadowRadius: CGFloat = 4
		static let shadowOpacity: Float = 0.2

		static let shadowOffsetWidth: CGFloat = 0
		static let shadowOffsetHeight: CGFloat = 4
	}

	convenience init(title: String,
					 titleColor: UIColor,
					 backgroundColor: UIColor,
					 font: UIFont?,
					 isShadow: Bool,
					 cornerRadius: CGFloat) {
		self.init(type: .system)

		self.setTitle(title, for: .normal)
		self.setTitleColor(titleColor, for: .normal)
		self.backgroundColor = backgroundColor
		self.titleLabel?.font = font
		self.layer.cornerRadius = cornerRadius

		if isShadow {
			self.layer.shadowColor = UIColor.black.cgColor
			self.layer.shadowRadius = Metrics.shadowRadius
			self.layer.shadowOpacity = Metrics.shadowOpacity
			self.layer.shadowOffset = CGSize(width: Metrics.shadowOffsetWidth,
											 height: Metrics.shadowOffsetHeight)
		}
	}

	convenience init(title: String,
					 titleColor: UIColor,
					 font: UIFont?) {
		self.init(type: .system)
		
		self.setTitle(title, for: .normal)
		self.setTitleColor(titleColor, for: .normal)
		self.titleLabel?.font = font
	}

	func customizeGoogleButton() {
		let googleLogo = UIImageView(image: #imageLiteral(resourceName: "googleLogo"), contentMode: .scaleAspectFit)
		googleLogo.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(googleLogo)
		
		NSLayoutConstraint.activate([
		googleLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
		googleLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}
}
