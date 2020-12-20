//
//  UIColor + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit

extension UIColor {
	static func buttonRed() -> UIColor {
		let color = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
		return color
	}

	static func mainWhite() -> UIColor {
		let color = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
		return color
	}

	static func buttonBlack() -> UIColor {
		let color = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
		return color
	}

	static func textFieldLight() -> UIColor {
		let color = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
		return color
	}

	static func startColorGradient() -> UIColor {
		let color = #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1)
		return color
	}

	static func endColorGradient() -> UIColor {
		let color = #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1)
		return color
	}

	static func sectionHeader() -> UIColor {
		let color = #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1)
		return color
	}

	static func tabBarTintColor() -> UIColor {
		let color = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
		return color
	}

}
