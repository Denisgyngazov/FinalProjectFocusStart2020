//
//  UILabel + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit

extension UILabel {

//	convenience init(text: String) {
//		self.init()
//
//		self.text = text
//	}

	convenience init(text: String, font: UIFont? = .avenirDefault()) {
		self.init()

		self.text = text
		self.font = font
	}

}
