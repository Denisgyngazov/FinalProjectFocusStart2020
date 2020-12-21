//
//  UIFont + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit

private enum Metrics {
	static let nameFont: String = "avenir"
	static let sizeFontButton: CGFloat = 20
	static let sizeFontTitle: CGFloat = 25
}

extension UIFont {
	static func avenirDefault() -> UIFont? {
		return UIFont.init(name: Metrics.nameFont,
						   size: Metrics.sizeFontButton)
	}

	static func avenirTitle() -> UIFont? {
		return UIFont.init(name: Metrics.nameFont,
						   size: Metrics.sizeFontTitle)
	}

	static func laoSangam20() -> UIFont? {
		return UIFont.init(name: "Lao Sangam MN", size: 20)
	}

	static func laoSangam18() -> UIFont? {
		return UIFont.init(name: "Lao Sangam MN", size: 18)
	}
}
